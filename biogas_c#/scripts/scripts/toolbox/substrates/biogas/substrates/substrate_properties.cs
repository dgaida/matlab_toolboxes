/**
 * MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
 * Copyright (C) 2014  Daniel Gaida
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
/**
* This file is part of the partial class substrate and defines
* its properties and private fields.
* 
* TODOs:
* - für das EEG 2012 müssen weitere Substratklassen eingeführt werden: classes
* 
* FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using System.IO;

/**
 * Mainly everything that has to do with biogas is defined in this namespace:
 * 
 * - Anaerobic Digestion Model
 * - CHPs
 * - Digesters
 * - Plant
 * - Substrates
 * - Chemistry used for biogas stuff
 * 
 */
namespace biogas
{
  /// <summary>
  /// Defines the physicochemical characteristics of a substrate used on biogas plants.
  /// 
  /// TODOs: add all substrates out of database.m
  /// check if all references in substrate.m have been used
  /// </summary>
  public partial class substrate
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the substrate
    /// </summary>
    private string _id= "";

    /// <summary>
    /// arbitrary descriptive name of the substrate
    /// </summary>
    private string _name= "";
    
    /// <summary>
    /// parameters out of the extended Weender analysis
    /// </summary>
    private struct weender
    {
      /// <summary>
      /// raw fiber
      /// TODO: LÖSCHEN - nein mache ich nicht, s. erklärung unten
      /// In Bestimmung des CSB aus TS wird RF einmal addiert, aber auch wieder substrahiert 
      /// (durch NfE Bestimmung) von daher ist der RF Wert total egal
      /// 
      /// Andererseits ist RF ein parameter des Substrats, welcher durch nichts anderes
      /// bestimmt werden kann, von daher schadet es auch nicht diesen zu messen
      /// auch wenn er nicht genutzt wird. NfE könnte ohne RF nicht bestimmt werden
      /// wobei NfE auch nicht genutzt wird.
      /// </summary>
      //[Obsolete("Delete in the future, because it is not used anymore.")]
      public physValue RF;
      /// <summary>
      /// raw protein
      /// </summary>
      public physValue RP;
      /// <summary>
      /// raw lipids
      /// </summary>
      public physValue RL;
      /// <summary>
      /// neutral detergent fiber
      /// NDF := ADF + Hemicellulose = Cellulose + ADL + Hemicellulose
      /// </summary>
      public physValue NDF;
      /// <summary>
      /// acid detergent fiber
      /// ADF := Cellulose + ADL
      /// </summary>
      public physValue ADF;
      /// <summary>
      /// acid detergent lignin
      /// </summary>
      public physValue ADL;
    }

    /// <summary>
    /// parameters out of the extended Weender analysis
    /// </summary>
    private weender Weender= new weender();
    
    private struct phys
    {
      ///// <summary>
      ///// total chemical oxygen demand
      ///// </summary>
      //[Obsolete("Delete in the future, not measured anymore.")]
      //public physValue COD;
      /// <summary>
      /// chemical oxygen demand of filtrate
      /// in Diss. called COD_filtrate
      /// </summary>
      public physValue COD_S;

      /// <summary>
      /// soluble inerts in substrate [kgCOD/m^3]
      /// </summary>
      public physValue SIin;

      ///// <summary>
      ///// specific heat capacity (specific heat)
      ///// TODO:
      ///// In Ganzheitliche stoffliche und energetische Modellierung S. 76
      ///// gibt es für einzelne Bestandteile (Protein, Fett, Kohlenhydrate, ...)
      ///// die Werte in kJ/kg/K, so dass man sich diesen Parameter auch berechnen
      ///// kann, funktion schreiben
      ///// 
      ///// diese Referenz müsste es geben, aber nicht zu finden in google:
      ///// calculation of heat capacity of substrate, choi & okos
      ///// titel heißt: thermal properties of liquid foods 
      ///// in physical and chemical properties of food, 1986
      ///// 
      ///// TODO: es gibt jetzt eine Funktion calcSpecificHeat() in substrate
      ///// oder weiterhin messen, aber wenn nicht in xml datei angegeben, dann berechnen
      ///// </summary>
      //[Obsolete("Delete in the future, not measured anymore.")]
      //public physValue c_th;
      /// <summary>
      /// pH value
      /// </summary>
      public physValue pH;
      ///// <summary>
      ///// density of the substrates fresh matter
      ///// 
      ///// TODO: es gibt jetzt eine Funktion: calcDensity in substrate
      ///// diese nutzen, rho nicht mehr messen
      ///// oder weiterhin messen, aber wenn nicht in xml datei angegeben, dann berechnen
      ///// </summary>
      //[Obsolete("Delete in the future, not measured anymore.")]
      //public physValue rho;

      /// <summary>
      /// acetic acid + acetate concentration
      /// </summary>
      public physValue Sac;
      /// <summary>
      /// butyric acid + butyrate concentration
      /// </summary>
      public physValue Sbu;
      /// <summary>
      /// propionic acid + propionate concentration
      /// </summary>
      public physValue Spro;
      /// <summary>
      /// valeric acid + valerate concentration
      /// </summary>
      public physValue Sva;

      /// <summary>
      /// ammonium nitrogen
      /// </summary>
      public physValue Snh4;
      /// <summary>
      /// total alkalinity
      /// TODO: sollte man in TA umbenennen
      /// </summary>
      public physValue TAC;

      ///// <summary>
      ///// total carbon in the fresh matter
      ///// </summary>
      //[Obsolete("Delete in the future, not measured anymore.")]
      //public physValue C;

      ///// <summary>
      ///// total nitrogen in the fresh matter
      ///// </summary>
      //[Obsolete("Delete in the future, not measured anymore.")]
      //public physValue N;

      /// <summary>
      /// temperature of the substrate
      /// </summary>
      public physValue T;

      /// <summary>
      /// total solids = VS + Ash
      /// </summary>
      public physValue TS;
      /// <summary>
      /// volatile solids = Xpr + Xli + Xch + NfE
      /// </summary>
      public physValue VS;

      /// <summary>
      /// degradation level (of volatile solids)
      /// </summary>
      public physValue D_VS;
    }

    private phys Phys= new phys();

    /// <summary>
    /// anaerobic digestion params
    /// </summary>
    private struct ad
    {
      /// <summary>
      /// disintegration rate
      /// </summary>
      public physValue kdis;

      /// <summary>
      /// hydrolysis rate carbohydrates
      /// </summary>
      public physValue khyd_ch;
      /// <summary>
      /// hydrolysis rate proteins
      /// </summary>
      public physValue khyd_pr;
      /// <summary>
      /// hydrolysis rate lipids
      /// </summary>
      public physValue khyd_li;

      /// <summary>
      /// max. uptake rate valerate and butyrate [1/d]
      /// 
      /// ist zwar kein Substratparameter, sondern eher eine Funktion des Systemzusandes
      /// aber so lange diese funktion nicht bekannt ist, wird eine Substrat-
      /// abhängigkeit modelliert, da Systemzustand ja auch von Substrate abhängt, 
      /// auch wenn nur indirekt. Parameter wird sicherlich auch von Fermenterbauform, und
      /// weiteres abhängen
      /// </summary>
      public physValue km_c4;

      /// <summary>
      /// max. uptake rate propionate [1/d]
      /// 
      /// ist zwar kein Substratparameter, sondern eher eine Funktion des Systemzusandes
      /// aber so lange diese funktion nicht bekannt ist, wird eine Substrat-
      /// abhängigkeit modelliert, da Systemzustand ja auch von Substrate abhängt, 
      /// auch wenn nur indirekt. Parameter wird sicherlich auch von Fermenterbauform, und
      /// weiteres abhängen
      /// </summary>
      public physValue km_pro;

      /// <summary>
      /// max. uptake rate acetate [1/d]
      /// 
      /// ist zwar kein Substratparameter, sondern eher eine Funktion des Systemzusandes
      /// aber so lange diese funktion nicht bekannt ist, wird eine Substrat-
      /// abhängigkeit modelliert, da Systemzustand ja auch von Substrate abhängt, 
      /// auch wenn nur indirekt. Parameter wird sicherlich auch von Fermenterbauform, und
      /// weiteres abhängen
      /// </summary>
      public physValue km_ac;

      /// <summary>
      /// max. uptake rate hydrogen [1/d]
      /// 
      /// ist zwar kein Substratparameter, sondern eher eine Funktion des Systemzusandes
      /// aber so lange diese funktion nicht bekannt ist, wird eine Substrat-
      /// abhängigkeit modelliert, da Systemzustand ja auch von Substrate abhängt, 
      /// auch wenn nur indirekt. Parameter wird sicherlich auch von Fermenterbauform, und
      /// weiteres abhängen
      /// </summary>
      public physValue km_h2;

    }

    /// <summary>
    /// anaerobic digestion params
    /// </summary>
    private ad AD= new ad();

    /// <summary>
    /// cost of substrate
    /// </summary>
    private physValue cost= new physValue("cost");

    /// <summary>
    /// age of substrate
    /// </summary>
    private physValue age = new physValue("age", 10, "d");

    /// <summary>
    /// type of substrate, e.g. maize, manure, cereals, grass, ...
    /// default: miscellaneous
    /// used to determine if substrate is a manure, used to determine
    /// the manure bonus (Güllebonus EEG 2009)
    /// and further to calculate statistics over the params of different
    /// sorts of maize, manure, ... to get mean values, etc.
    /// </summary>
    private string substrate_class= "miscellaneous";

    /// <summary>
    /// Substrate classes available
    /// 
    /// htk = Hühnertrockenkot
    /// ccm = corn-cob mix
    /// 
    /// TODO
    /// für das EEG 2012 müssen weitere Substratklassen eingeführt werden
    /// 
    /// wenn man die Liste alphabetisch sortiert haben möchte, dann hier.
    /// nicht in gui alphabetisch sortieren, wegen methode
    /// biogas.substrate.getIndexOfSubstrateClass (s. substrate_get_params.cs)
    /// nach EK und dann alphabetisch sortiert
    /// 
    /// Quelle: Verguetungsrechner_Biogas_EEG_2012
    /// DBFZ Version 1.6
    /// 
    /// können Sonderzeichen wie ü, ä, ... in Namen genutzt werden?
    /// </summary>
    static public List<string> classes=
      new List<string>{
        "Getreideabfälle (EK 0)", "Glycerin (EK 0)", "Grünschnitt Garten-/Parkpflege (EK 0)", 
        "Straßenbegleitgras (EK 0)", "Zuckerrübenschnitzel (EK 0)", "Sonstiges (EK 0)", 

        "Corn-Cob-Mix (CCM) (EK I)", "Futterrüben (EK I)", "Futterrübenblatt (EK I)", 
        "Getreide (GPS) (EK I)", "Getreidekorn (EK I)", "Gras/Ackergras (EK I)", 
        "Grünroggen (GPS) (EK I)", "Hülsenfrüchte (GPS) (EK I)", 
        "Körnermais (EK I)", "Lieschkolbenschrot (EK I)", "Mais (GPS) (EK I)", 
        "Sonnenblume (GPS) (EK I)", "Sorghum (GPS) (EK I)", "Sudangras (EK I)", 
        "Zuckerrüben (EK I)", 
        "Sonstiges (EK I)", 

        "Geflügelmist/HTK (EK II)", "Kleegras (EK II)", "Landschaftspflegematerial/-gras (EK II)", 
        "Pferdemist (EK II)", "Rinderfestmist (EK II)", "Rindergülle (EK II)", 
        "Schafs-/Ziegenmist (EK II)", "Schweinefestmist (EK II)", 
        "Schweinegülle (EK II)", "Stroh (EK II)", 
        "Sonstiges (EK II)", 

        "Miscellaneous"};



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// id of the substrate
    /// </summary>
    public string id
    {
      get { return _id; }
    }

    /// <summary>
    /// arbitrary descriptive name of the substrate
    /// </summary>
    public string name
    {
      get { return _name; }
    }


    /// <summary>
    /// true, if substrate is a kind of manure, else false
    /// depends on substrate_class
    /// 
    /// Quelle: Biogas_Invest_2.1_160812.xls (3 Einsatzstoffe)
    /// LeL Schwäbisch Gmünd
    /// </summary>
    public bool ismanure
    {
      get { return (
        (substrate_class == "Rinderfestmist (EK II)") ||
        (substrate_class == "Rindergülle (EK II)") ||
        (substrate_class == "Schweinefestmist (EK II)") ||
        (substrate_class == "Schweinegülle (EK II)") ||
        (substrate_class == "Schafs-/Ziegenmist (EK II)") ||
        (substrate_class == "Pferdemist (EK II)"));
      }
    }

    /// <summary>
    /// true, if substrate belongs to Mais oder Getreide ->
    /// Mais-/Getreideckel von 60 %, else false
    /// 
    /// Quelle: Biogas_Invest_2.1_160812.xls (3 Einsatzstoffe)
    /// LeL Schwäbisch Gmünd
    /// </summary>
    /// <returns></returns>
    public bool belongsToMaisDeckel
    { 
      get { return (
        (substrate_class == "Mais (GPS) (EK I)") ||
        (substrate_class == "Getreidekorn (EK I)") ||
        (substrate_class == "Corn-Cob-Mix (CCM) (EK I)") ||
        (substrate_class == "Körnermais (EK I)") ||
        (substrate_class == "Lieschkolbenschrot (EK I)"));
      }
    }


  
  }
}


