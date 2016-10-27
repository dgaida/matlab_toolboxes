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
* This file is part of the partial class chemistry and defines
* the fields and properties of the class.
* 
* TODOs: 
* - Acid dissociation constant are temperature dependent
* - Specific volume of biogas is temperature dependent
* - Most parameters are temperature dependent
* 
* Apart from that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;

using science;
using toolbox;

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
  /**
   * Defines a few methods in the field of chemistry used in the biogas area
   * 
   * References:
   * 
   * 1) Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
   *    Biogas from grass silage – Measurements and modeling with ADM1, 
   *    Bioresource Technology 101, pp. 8158-8165, 2010.
   *    
   * 2) Gaida, D.: 
   *    Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und Regelung -, 
   *    2009
   * 
   */
  public partial class chemistry
  {

    // -------------------------------------------------------------------------------------
    //                           !!! PRIVATE PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// molar mass of Carbon is   12 g/mol
    /// </summary>
    private static physValue mol_mass_C= new physValue("M_C", 12, "g/mol");
    /// <summary>
    /// molar mass of Hydrogen is  1 g/mol
    /// </summary>
    private static physValue mol_mass_H= new physValue("M_H", 1, "g/mol");
    /// <summary>
    /// molar mass of Oxygen is   16 g/mol
    /// </summary>
    private static physValue mol_mass_O= new physValue("M_O", 16, "g/mol");
    /// <summary>
    /// molar mass of Nitrogen is 14 g/mol
    /// </summary>
    private static physValue mol_mass_N= new physValue("M_N", 14, "g/mol");
    /// <summary>
    /// molar mass of Sulfur is   32 g/mol
    /// </summary>
    private static physValue mol_mass_S= new physValue("M_S", 32, "g/mol");
    /// <summary>
    /// molar mass of Calcium is  40 g/mol
    /// </summary>
    //private static physValue mol_mass_Ca= new physValue("M_Ca", 40, "g/mol");



    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // As the calculation of the next fields take some time, they are calculated
    // once and used in the class methods
    
    /// <summary>
    /// COD of methane in gCOD/mol
    /// </summary>
    private static physValue COD_Sch4= get_COD_of("Sch4", true);
    


    /// <summary>
    /// COD of acetic acid in gCOD/mol
    /// </summary>
    private static physValue COD_Sac= get_COD_of("Sac", false);
    /// <summary>
    /// COD of propionic acid in gCOD/mol
    /// </summary>
    private static physValue COD_Spro= get_COD_of("Spro", false);
    /// <summary>
    /// COD of butyric acid in gCOD/mol
    /// </summary>
    private static physValue COD_Sbu= get_COD_of("Sbu", false);
    /// <summary>
    /// COD of valeric acid in gCOD/mol
    /// </summary>
    private static physValue COD_Sva= get_COD_of("Sva", false);



    /// <summary>
    /// Theoretical Oxygen Demand (gCOD/g) of Xch (Carbohydrates)
    /// </summary>
    public static physValue ThODch= biogas.chemistry.calcTheoreticalOxygenDemand("Xch");
    /// <summary>
    /// Theoretical Oxygen Demand (gCOD/g) of Xpr (Proteins)
    /// </summary>
    public static physValue ThODpr= biogas.chemistry.calcTheoreticalOxygenDemand("Xpr");
    /// <summary>
    /// Theoretical Oxygen Demand (gCOD/g) of Xli (Lipids)
    /// </summary>
    public static physValue ThODli= biogas.chemistry.calcTheoreticalOxygenDemand("Xli");
    /// <summary>
    /// Theoretical Oxygen Demand (gCOD/g) of Lignin
    /// </summary>
    public static physValue ThODl=  biogas.chemistry.calcTheoreticalOxygenDemand("Lignin");

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



    // -------------------------------------------------------------------------------------
    //                           !!! PUBLIC PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calorific value (Brennwert) of methane measured in kWh / ( Nm^3 )
    /// Der Brennwert eines Brennstoffes gibt die Wärmemenge an, die bei Verbrennung und 
    /// anschließender Abkühlung der Verbrennungsgase auf 25 °C sowie deren Kondensation 
    /// freigesetzt wird.
    /// 
    /// ich brauche doch den brennwert, da die Verdampfungswärme doch mitgenutzt wird zur
    /// Energieerzeugung. 
    /// http://www.kwk-forum.de/board76-sch%C3%BCler-und-studentenbereich/board77-grundsatzfragen-kwk-bhkw-sch%C3%BCler-und-studentenbereich/806-heizwert-und-brennstofflesitung-bhkw/
    /// Die Werte (Wirkungsgrade) im Datenblatt müssen sich inzwischen auf den Brennwert beziehen. 
    /// 
    /// Ich würde den Heizwert als maximal nutzbaren Energieinhalt bezeichnen, der ohne Kondensation 
    /// der Abgase zu erzielen ist. Alte Heizungen oder auch KWK Anlagen mit einer Abgastemperatur 
    /// von > 100 Grad nutzen die Kondensationswärme der Abgase nicht und "verschenken" und verschwenden 
    /// damit Energie.
    /// 
    /// Die tatsächliche Brennstoffleistung würde ich als Brennwert im Normzustand ansehen, d.h. die 
    /// höchstmögliche Brennstoffnutzung bei maximaler Kondensation der Abgase
    /// 
    /// FEHLER!!! ich brauche hier den Heizwert, nicht den Brennwert!!!
    /// heating value
    /// 35,883 MJ/m^3 (Normalbedingungen (0 °C und 101325 Pa))
    /// bei 25 °C und 101325 Pa: aus Diss.: 802.60 / 24.465 = 32.8060
    /// s. Diss oder unten bei H2, V hat einen etwas anderen Wert, deshalb hier 32.944
    /// 
    /// http://en.wikipedia.org/wiki/Molar_volume#Ideal_gases
    ///
    /// Nm³ stands for normed cubicmeter, which defines a cubicmeter of gas
    /// at a certain pressure, humidity and temperature (25 °C)
    ///
    /// The calorific value of CO2 is zero (because it can't be burned)
    ///
    /// ~ 39.8 MJ/m³ (25 °C) (Normalbedingungen (0 °C und 101325 Pa))
    /// 
    /// http://de.wikipedia.org/wiki/Heizwert
    ///
    /// http://en.wikipedia.org/wiki/Heat_of_combustion
    /// 
    /// For historical reasons, the efficiency of power plants and combined heat and power plants 
    /// in Europe may have once been calculated based on the LHV. However, this does not seem to be 
    /// the case nowadays and most countries are tending to correctly use HHV for true efficiency figures.
    /// 
    /// This has the peculiar result that contemporary combined heat and power plants, where flue-gas 
    /// condensation is implemented, may report efficiencies exceeding 100%
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static physValue Hch4 = 
      new science.physValue("Hch4", 39.8/*Heizwert 32.944*/, "MJ/m^3").convertUnit("kWh/m^3");

    /// <summary>
    /// Calorific value of molecular hydrogen : 11.7 MJ/m³ (25 °C)
    ///
    /// FEHLER!!! ich brauche hier den Heizwert, nicht den Brennwert!!!
    /// heating value
    /// 10,783 MJ/m^3 (Normalbedingungen (0 °C und 101325 Pa))
    /// bei 25 °C und 101325 Pa: aus Diss.: 241.81 / 24.3620 = 9.9257
    /// Volumen berechnet sich nach DIN 51857, mit einem Korrektuterm Z, s. Diss
    /// 
    /// http://de.wikipedia.org/wiki/Heizwert
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static physValue Hh2= 
      new science.physValue("Hh2", 11.7/*Heizwert 9.9257*/, "MJ/m^3").convertUnit("kWh/m^3");

    /// <summary>
    /// atmospheric pressure (external pressure, Außendruck): 1.04 bar
    /// </summary>
    public static physValue pAtm= new physValue("pAtm", 1.04, "bar", "atmospheric pressure");

    /// <summary>
    /// gas constant: 0.08313... m^3 * bar / ( kmol * K )
    /// </summary>
    public static physValue R= 
              new physValue("R", 8.313999999999999 * Math.Pow(10, -2),
                            "m^3 * bar / ( kmol * K )", "gas constant");

    /// <summary>
    /// Norm cubic meter [mol/m^3]
    /// 
    /// Vm approx 1000/NQ
    /// </summary>
    public static physValue NQ= new physValue("NQ", 44.64300, "mol/m^3");

    /// <summary>
    /// molar volume of an ideal gas at 1 atmosphere of pressure at 25 °C
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static physValue Vm= new physValue("Vm", 24.465, "l/mol");

    //

    /// <summary>
    /// Specific volume of methane (1.013 bar and 21 °C (70 °F))
    /// 
    /// http://encyclopedia.airliquide.com/Encyclopedia.asp?GasID=41
    /// 
    /// TODO: temperature dependent
    /// </summary>
    private static physValue Vch4= new physValue("Vch4", 1.48, "m^3/kg");

    /// <summary>
    /// Specific volume of carbon dioxide (1.013 bar and 21 °C (70 °F))
    /// 
    /// http://encyclopedia.airliquide.com/Encyclopedia.asp?GasID=26
    /// 
    /// TODO: temperature dependent
    /// </summary>
    private static physValue Vco2= new physValue("Vco2", 0.547, "m^3/kg");

    /// <summary>
    /// Specific volume of ammonia (1.013 bar and 21 °C (70 °F))
    /// 
    /// http://encyclopedia.airliquide.com/Encyclopedia.asp?GasID=2
    /// 
    /// TODO: temperature dependent
    /// </summary>
    private static physValue Vnh3= new physValue("Vnh3", 1.411, "m^3/kg");

    /// <summary>
    /// Specific volume of hydrogen sulfide (1.013 bar and 21 °C (70 °F))
    /// 
    /// http://encyclopedia.airliquide.com/Encyclopedia.asp?GasID=59
    /// 
    /// TODO: temperature dependent
    /// </summary>
    private static physValue Vh2s= new physValue("Vh2s", 0.699, "m^3/kg");

    //

    /// <summary>
    /// Acid dissociation constant: pK_S value of acetic acid
    /// source= ?, aren't they temperature dependent? TODO
    /// ja, Van 't Hoff equation
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static double pK_S_ac= 4.76;

    /// <summary>
    /// Acid dissociation constant: pK_S value of propionic acid
    /// source= ?, aren't they temperature dependent? TODO
    /// ja, Van 't Hoff equation
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static double pK_S_pro= 4.88;

    /// <summary>
    /// Acid dissociation constant: pK_S value of butyric acid
    /// source= ?, aren't they temperature dependent? TODO
    /// ja, Van 't Hoff equation
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static double pK_S_bu= 4.82;

    /// <summary>
    /// Acid dissociation constant: pK_S value of valeric acid
    /// source= ?, aren't they temperature dependent? TODO
    /// ja, Van 't Hoff equation
    /// 
    /// TODO: is also temperature dependent
    /// </summary>
    public static double pK_S_va= 4.82;



  }
}


