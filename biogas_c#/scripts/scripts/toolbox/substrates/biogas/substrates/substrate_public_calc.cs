/**
 * This file is part of the partial class substrate and contains
 * public methods which calculate something, so "calc" methods.
 * 
 * TODOs:
 * - 
 * 
 * FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using System.Xml;
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
  /// </summary>
  public partial class substrate
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC CALC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates Carbon-to-nitrogen (C to N) ratio in the fresh matter.
    /// For agricultural purposes, a compost should have a C/N ratio of 20-30:1.
    /// 
    /// http://en.wikipedia.org/wiki/Carbon-to-nitrogen_ratio
    /// </summary>
    /// <returns>C / N ratio in FM</returns>
    public double calcCtoNratio()
    {
      physValue[] values= new physValue[2];

      try
      {
        get_params_of(out values, "C", "N");
      }
      catch (exception e)
      { 
        Console.WriteLine(e.Message);
        return 0;
      }

      physValue C= values[0].convertUnit("g/kg");
      physValue N= values[1].convertUnit("g/kg");

      if (N.Value == 0)
        return 0;

      return (C / N).Value;
    }



    /// <summary>
    /// calc NH3 out of NH4 and pH of substrate
    /// </summary>
    /// <returns>NH3 value in kmol/m^3</returns>
    public physValue calcSnh3()
    {
      return calcSnh3(this);
    }
    /// <summary>
    /// calc NH3 out of NH4 and pH of substrate
    /// </summary>
    /// <param name="mySubstrate"></param>
    /// <returns>NH3 value in kmol/m^3</returns>
    public static physValue calcSnh3(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "Snh4", "pH");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Snh3");
      }

      physValue Snh4 = values[0];
      physValue pH = values[1];

      return calcSnh3(Snh4, pH);
    }
    /// <summary>
    /// calc NH3 out of NH4 and pH of substrate
    /// </summary>
    /// <param name="Snh4">NH4 value must be measured in g/l</param>
    /// <param name="pH">pH value</param>
    /// <returns>NH3 value in kmol/m^3</returns>
    public static physValue calcSnh3(double Snh4, double pH)
    {
      physValue pSnh4 = new physValue("Snh4", Snh4, "g/l");
      physValue p_pH = new physValue("pH", pH, "-");

      return calcSnh3(pSnh4, p_pH);
    }
    /// <summary>
    /// calc NH3 out of NH4 and pH of substrate
    /// </summary>
    /// <param name="pSnh4">NH4 value</param>
    /// <param name="pH">the pH value</param>
    /// <returns>NH3 value in kmol/m^3</returns>
    public static physValue calcSnh3(physValue pSnh4, physValue pH)
    {
      double Snh4 = pSnh4.convertUnit("kmol/m^3").Value;

      // Ammonia:
      //
      // Ebenfalls ein Säure-Basen GG zwischen Ammoniak und Ammonium
      //
      // pK_S := -log_10 (K_S) -> K_S= 10^(-pK_S)
      // pK_S= 9.25 für das GG
      //
      // pH := -log_10(c(H^+))
      // c(H^+)= 10^(-pH)
      //
      // K_S= \frac{c(H^+) \cdot c(NH_3)}{c(NH_4)}
      // 10^(-9.25)= \frac{10^(-pH) \cdot SNH_3}{SIN_}
      // 
      //
      // $SNH3(t)= \frac{ 10^{ \left( pH - 9 + \log_{10}( SIN\_(t) / 14 ) \right)
      // } }{1000 \cdot 14}  
      // ~~~~~~~~~~ \left[ \frac{k mol N}{m^3} \right]$
      //
      // log10((NH4 / 14) / (Snh3 * 1000)) = pH - 9
      // anstatt 9 eigentlich 9.25

      double Snh3 = Math.Pow(10, pH.Value - 9.25) * Snh4;

      return new physValue("Snh3", Snh3, "kmol/m^3");
    }


    /// <summary>
    /// calc Shco3 of substrate out of total alkalinity, acids and an-/cations
    /// </summary>
    /// <returns>HCO_3 (bicarbonate) in kmol/m^3</returns>
    /// <exception cref="exception">Could not convert TAC, San or Scat</exception>
    public physValue calcShco3()
    {
      return calcShco3(this);
    }
    /// <summary>
    /// calc Shco3 of substrate out of total alkalinity, acids and an-/cations
    /// </summary>
    /// <param name="mySubstrate">substrate object</param>
    /// <returns>HCO_3 (bicarbonate) in kmol/m^3</returns>
    /// <exception cref="exception">Could not convert TAC, San or Scat</exception>
    public static physValue calcShco3(substrate mySubstrate)
    {
      physValue[] values = new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "TAC", "Sva_", "Sbu_", "Spro_", "Sac_", "San", "Scat");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Shco3");
      }

      physValue TAC = values[0];
      physValue Sva_ = values[1];
      physValue Sbu_ = values[2];
      physValue Spro_ = values[3];
      physValue Sac_ = values[4];
      physValue San = values[5];
      physValue Scat = values[6];

      return calcShco3(TAC, Sva_, Sbu_, Spro_, Sac_, San, Scat);
    }
    /// <summary>
    /// calc Shco3 of substrate out of total alkalinity, acids and an-/cations
    /// </summary>
    /// <param name="pTAC">total alkalinity, must be given in kmol/m^3</param>
    /// <param name="pSva_">valerate</param>
    /// <param name="pSbu_">butyrate</param>
    /// <param name="pSpro_">propionate</param>
    /// <param name="pSac_">acetate</param>
    /// <param name="pSan">anions, must be given in kmol/m^3</param>
    /// <param name="pScat">cations, must be given in kmol/m^3</param>
    /// <returns>HCO_3 (bicarbonate) in kmol/m^3</returns>
    /// <exception cref="exception">Could not convert TAC, San or Scat</exception>
    public static physValue calcShco3(physValue pTAC, physValue pSva_, physValue pSbu_, 
      physValue pSpro_, physValue pSac_, physValue pSan, physValue pScat)
    {
      // TODO: glaube nicht, dass ich TAC immer konvertieren könnte, da ich mit 50 g/l rechnen müsste
      // nur mol/l und kmol/m^3 geht umzurechnen
      // kann also Fehler werfen
      double TAC = pTAC.convertUnit("kmol/m^3").Value;
      double Sva_ = pSva_.convertUnit("kmol/m^3").Value;
      double Sbu_ = pSbu_.convertUnit("kmol/m^3").Value;
      double Spro_ = pSpro_.convertUnit("kmol/m^3").Value;
      double Sac_ = pSac_.convertUnit("kmol/m^3").Value;
      // TODO San und Scat können nicht immer umgerechnet werden
      // nur von mol/m^3 in kmol/m^3
      // kann also Fehler werfen
      double San = pSan.convertUnit("kmol/m^3").Value;
      double Scat = pScat.convertUnit("kmol/m^3").Value;

      // laut Schön gilt
      // 09 Population dynamics at digester overload conditions
      // TAC [g/l] = ( San + Shco3 + Sac_/64 + SPro_/112 + SBu_/160 + Sva_/208 - Scat ) * 50 g/mol
      // d.h.
      // Shco3= TAC/50 - San - Sac_/64 - SPro_/112 - SBu_/160 - Sva_/208 + Scat

      // der TAC hier ist gemessen in kmol/m³, deshalb entfällt umrechnungsfaktor 50, 
      // sowie San und Scat in kmol/m³
      // Säuren werden in kgCOD/m³ gemessen, geteilt durch mol masse in g/mol ergibt kmol/m³

      double Shco3 = Math.Max(TAC - San - Sac_ - Spro_ - Sbu_ - Sva_ + Scat, 0);

      return new physValue("Shco3", Shco3, "kmol/m^3", "bicarbonate");
    }

    /// <summary>
    /// calc CO2 out of HCO3 and pH of substrate
    /// </summary>
    /// <returns>CO2 value in kmol/m^3</returns>
    public physValue calcSco2()
    {
      return calcSco2(this);
    }
    /// <summary>
    /// calc CO2 out of HCO3 and pH of substrate
    /// </summary>
    /// <param name="mySubstrate"></param>
    /// <returns>CO2 value in kmol/m^3</returns>
    public static physValue calcSco2(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "Shco3", "pH");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Sco2");
      }

      physValue Shco3 = values[0];
      physValue pH = values[1];

      return calcSco2(Shco3, pH);
    }
    /// <summary>
    /// calc CO2 out of HCO3 and pH of substrate
    /// </summary>
    /// <param name="pShco3">HCO3 value</param>
    /// <param name="pH">the pH value</param>
    /// <returns>CO2 value in kmol/m^3</returns>
    public static physValue calcSco2(physValue pShco3, physValue pH)
    {
      double Shco3 = pShco3.convertUnit("kmol/m^3").Value;

      // Formel is umrechenbar zu:
      //
      // TODO: anstatt TAC müsste da Shco3 stehen
      //
      // pH + log10(Sco2 * 1000) = 6.3 + log10(Shco3)
      // pH - 6.3 = log10(TAC / (Sco2 * 1000))
      // -log10(Sco2 * 1000/TAC) = pH - 6.3
      // anstatt 6.3 gilt eigentlich 6.52 -> für gleichgewicht mit kohlensäure gilt 6.3, sollte
      // also so stimmen
      //

      double Sco2;

      // TODO
      // es ist davon auszugehen, dass bei silierten Substraten ein Großteil des
      // CO2s in die gasphase übergeht und nicht mehr im wasser des substrats gebunden ist
      // müsste mit steigendem TS gehalt steigen, der gehalt an CO2 im Gas
      // hier wird CO2 einfach durch HCO3 begrenzt und durch 10 geteilt, kann nicht begründet werden
      // 
      if (Shco3 > 0)
      {
        // in kmol/m³
        //Sco2 = Math.Min(Math.Pow(10, 6.3 + Math.Log10(Shco3) - pH) / 10, Shco3);// / 1000;
        // TODO - test this!
        Sco2 = Math.Min(Math.Pow(10, 6.3 - pH.Value) * Shco3, 100*Shco3);// / 1000;
      }
      else
        Sco2 = 0;

      // TODO - test
      // gasförmiges CO2 dürfte direkt in die Atmosphäre gehen, wenn es im substrat war
      // wirkt sehr stark auf das CO2 in Biogas, hier ein bisschen, schon fällt 
      // methankonzentration um ein paar Prozent
      //Sco2 = 0;

      return new physValue("Sco2", Sco2, "kmol/m^3");
    }

    /// <summary>
    /// calc pH value out of TAC and NH4
    /// see ADMstate.calcPHOfADMstate as well
    /// </summary>
    /// <returns>pH value</returns>
    public physValue calc_pH()
    {
      return calc_pH(this);
    }
    /// <summary>
    /// calc pH value out of TAC and NH4
    /// see ADMstate.calcPHOfADMstate as well
    /// </summary>
    /// <param name="mySubstrate">substrate object</param>
    /// <returns>pH value</returns>
    public static physValue calc_pH(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "TAC", "Snh4");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        LogError.Log_Err("substrate.calc_pH", e);
        return new physValue("error pH");
      }

      physValue TAC = values[0];
      physValue Snh4 = values[1];
      
      return calc_pH(TAC, Snh4);
    }
    /// <summary>
    /// calc pH value out of TAC and NH4
    /// see ADMstate.calcPHOfADMstate as well
    /// </summary>
    /// <param name="pTAC">total alkalinity</param>
    /// <param name="pSnh4">ammonium</param>
    /// <returns>pH value</returns>
    public static physValue calc_pH(physValue pTAC, physValue pSnh4)
    {
      double TAC = pTAC.convertUnit("kmol/m^3").Value;
      double Snh4 = pSnh4.convertUnit("kmol/m^3").Value;

      double pfac_h = -TAC + Snh4;

      // s. p_adm1xp.m file, eigentlich müsste das 1* 10^-14 sein???, da Kw
      // Temperatur abhängig ist, ist das ok, da der Wert mit steigender
      // Temperatur steigt
      // http://de.wikipedia.org/wiki/Eigenschaften_des_Wassers#Ionenprodukt
      // http://en.wikipedia.org/wiki/Dissociation_constant#Dissociation_constant_of_water
      double Kw = 2.08e-14;

      // SH ist immer positiv
      // da der zweite term immer größer als wie der erste term ist
      double SH = -1 * pfac_h / 2 + 0.5 * Math.Pow(pfac_h * pfac_h + 4 * Kw, 0.5);

      double pH = -Math.Log10(SH);

      return new physValue("pH", pH, "-");
    }


    /// <summary>
    /// calc valerate out of total valeric acid concentration and pH value
    /// </summary>
    /// <returns>valerate in kgCOD/m^3</returns>
    public physValue calcSva_()
    {
      return calcSva_(this);
    }
    /// <summary>
    /// calc valerate out of total valeric acid concentration and pH value
    /// </summary>
    /// <param name="mySubstrate">substrate object</param>
    /// <returns>valerate in kgCOD/m^3</returns>
    public static physValue calcSva_(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "Sva", "pH");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Sva_");
      }

      physValue Sva = values[0];
      physValue pH = values[1];

      return calcSva_(Sva, pH);
    }
    /// <summary>
    /// calc valerate out of total valeric acid concentration and pH value
    /// </summary>
    /// <param name="pSva">total valeric acid inside substrate</param>
    /// <param name="pH">pH value of substrate</param>
    /// <returns>valerate in kgCOD/m^3</returns>
    public static physValue calcSva_(physValue pSva, physValue pH)
    {
      double Sva = pSva.convertUnit("kgCOD/m^3").Value;

      double Sva_ = Sva / (1 + Math.Pow(10, chemistry.pK_S_va - pH.Value));

      return new physValue("Sva_", Sva_, "kgCOD/m^3");
    }

    /// <summary>
    /// calc butyrate out of total butyric acid concentration and pH value
    /// </summary>
    /// <returns>butyrate in kgCOD/m^3</returns>
    public physValue calcSbu_()
    {
      return calcSbu_(this);
    }
    /// <summary>
    /// calc butyrate out of total butyric acid concentration and pH value
    /// </summary>
    /// <param name="mySubstrate">substrate object</param>
    /// <returns>butyrate in kgCOD/m^3</returns>
    public static physValue calcSbu_(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "Sbu", "pH");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Sbu_");
      }

      physValue Sbu = values[0];
      physValue pH = values[1];

      return calcSbu_(Sbu, pH);
    }
    /// <summary>
    /// calc butyrate out of total butyric acid concentration and pH value
    /// </summary>
    /// <param name="pSbu">total butyric acid inside substrate</param>
    /// <param name="pH">pH value of substrate</param>
    /// <returns>butyrate in kgCOD/m^3</returns>
    public static physValue calcSbu_(physValue pSbu, physValue pH)
    {
      double Sbu = pSbu.convertUnit("kgCOD/m^3").Value;

      double Sbu_ = Sbu / (1 + Math.Pow(10, chemistry.pK_S_bu - pH.Value));

      return new physValue("Sbu_", Sbu_, "kgCOD/m^3");
    }

    /// <summary>
    /// calc propionate out of total propionic acid concentration and pH value
    /// </summary>
    /// <returns>propionate in kgCOD/m^3</returns>
    public physValue calcSpro_()
    {
      return calcSpro_(this);
    }
    /// <summary>
    /// calc propionate out of total propionic acid concentration and pH value
    /// </summary>
    /// <param name="mySubstrate">substrate object</param>
    /// <returns>propionate in kgCOD/m^3</returns>
    public static physValue calcSpro_(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "Spro", "pH");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Spro_");
      }

      physValue Spro = values[0];
      physValue pH = values[1];

      return calcSpro_(Spro, pH);
    }
    /// <summary>
    /// calc propionate out of total propionic acid concentration and pH value
    /// </summary>
    /// <param name="pSpro">total propionic acid inside substrate</param>
    /// <param name="pH">pH value of substrate</param>
    /// <returns>propionate in kgCOD/m^3</returns>
    public static physValue calcSpro_(physValue pSpro, physValue pH)
    {
      double Spro = pSpro.convertUnit("kgCOD/m^3").Value;

      double Spro_ = Spro / (1 + Math.Pow(10, chemistry.pK_S_pro - pH.Value));

      return new physValue("Spro_", Spro_, "kgCOD/m^3");
    }

    /// <summary>
    /// calc acetate out of total acetic acid concentration and pH value
    /// </summary>
    /// <returns>acetate in kgCOD/m^3</returns>
    public physValue calcSac_()
    {
      return calcSac_(this);
    }
    /// <summary>
    /// calc acetate out of total acetic acid concentration and pH value
    /// </summary>
    /// <param name="mySubstrate">substrate object</param>
    /// <returns>acetate in kgCOD/m^3</returns>
    public static physValue calcSac_(substrate mySubstrate)
    {
      physValue[] values = new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "Sac", "pH");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error Sac_");
      }

      physValue Sac = values[0];
      physValue pH = values[1];

      return calcSac_(Sac, pH);
    }
    /// <summary>
    /// calc acetate out of total acetic acid concentration and pH value
    /// </summary>
    /// <param name="pSac">total acetic acid inside substrate</param>
    /// <param name="pH">pH value of substrate</param>
    /// <returns>acetate in kgCOD/m^3</returns>
    public static physValue calcSac_(physValue pSac, physValue pH)
    {
      double Sac = pSac.convertUnit("kgCOD/m^3").Value;

      double Sac_ = Sac / (1 + Math.Pow(10, chemistry.pK_S_ac - pH.Value));

      return new physValue("Sac_", Sac_, "kgCOD/m^3");
    }

    
    /// <summary>
    /// Berechnung von Biomasse, gilt nur für Gülle
    /// Biomasse der Methanogenese
    /// bei Gülle ist durchaus biomasse vorhanden
    /// s. Modelling the energy balance of an anaerobic digester ... Lübken
    /// </summary>
    /// <returns>methane producing bacteria kgCOD/m^3</returns>
    public physValue calcXmethan()
    {
      physValue Xbac, Xmeth;

      calcXbiomass(out Xbac, out Xmeth);

      return Xmeth;
    }
    /// <summary>
    /// Berechnung von Biomasse, gilt nur für Gülle
    /// Biomasse außer der der Methanogenese
    /// bei Gülle ist durchaus biomasse vorhanden
    /// s. Modelling the energy balance of an anaerobic digester ... Lübken
    /// </summary>
    /// <returns>all other bacteria kgCOD/m^3</returns>
    public physValue calcXbacteria()
    {
      physValue Xbac, Xmeth;

      calcXbiomass(out Xbac, out Xmeth);

      return Xbac;
    }
    /// <summary>
    /// Berechnung von Bionmasse, gilt nur für Gülle
    /// 
    /// bei Gülle ist durchaus biomasse vorhanden
    /// s. Modelling the energy balance of an anaerobic digester ... Lübken
    /// </summary>
    /// <param name="Xbacteria">all other bacteria kgCOD/m^3</param>
    /// <param name="Xmethan">methane producing bacteria kgCOD/m^3</param>
    public void calcXbiomass(out double Xbacteria, out double Xmethan)
    {
      physValue pXbac, pXmeth;

      calcXbiomass(out pXbac, out pXmeth);

      Xbacteria = pXbac.Value;
      Xmethan = pXmeth.Value;
    }
    /// <summary>
    /// Berechnung von Bionmasse, gilt nur für Gülle
    /// 
    /// bei Gülle ist durchaus biomasse vorhanden
    /// s. Modelling the energy balance of an anaerobic digester ... Lübken
    /// </summary>
    /// <param name="pXbacteria">all other bacteria kgCOD/m^3</param>
    /// <param name="pXmethan">methane producing bacteria kgCOD/m^3</param>
    public void calcXbiomass(out physValue pXbacteria, out physValue pXmethan)
    {
      calcXbiomass(this, out pXbacteria, out pXmethan);
    }
    /// <summary>
    /// Berechnung von Bionmasse, gilt nur für Gülle
    /// 
    /// bei Gülle ist durchaus biomasse vorhanden
    /// s. Modelling the energy balance of an anaerobic digester ... Lübken
    /// </summary>
    /// <param name="mySubstrate"></param>
    /// <param name="pXbacteria">all other bacteria kgCOD/m^3</param>
    /// <param name="pXmethan">methane producing bacteria kgCOD/m^3</param>
    public static void calcXbiomass(substrate mySubstrate, out physValue pXbacteria, 
                                                           out physValue pXmethan)
    {
      double Xbacteria = 0;
      double Xmethan = 0;

      if (mySubstrate.ismanure)
      {
        //double iCOD_VS = 1.5611;    // gCOD/gVS
        double Ncells = 1.47 * Math.Pow(10, 10);    // cells/ml
        double fbac = 0.85;       // 100 %
        double fmethan = 0.01;    // 100 %
        double mcell = 14.0f * Math.Pow(10, -11);    // mg/cell
        double iCOD_Xbac = 1.416;    // gCOD/gbiomass

        // cells/ml * 1 * mg/cell * gCOD/gbiomass = 
        // gCOD/l * 1000 l/m^3 * k/1000 = kgCOD/m^3
        // TODO: verstehe Faktor 10^-3 in lübken veröffentlichung nicht
        Xbacteria = Ncells * fbac * mcell * iCOD_Xbac;// *Math.Pow(10, -3);

        physValue age = mySubstrate.age;
        // TODO - convert to days

        Xbacteria = Xbacteria * Math.Pow(10, - age.Value / 10); // expected Halbwertszeit: 10 days

        Xmethan = Ncells * fmethan * mcell * iCOD_Xbac;

        Xmethan = Xmethan * Math.Pow(10, -age.Value / 5); // expected Halbwertszeit: 5 days
      }

      pXbacteria = new physValue("Xbac", Xbacteria, "kgCOD/m^3");
      pXmethan = new physValue("Xmethan", Xmethan, "kgCOD/m^3");
    }

    /// <summary>
    /// calc XcIN, XcIN is a component of the ADM input vector
    /// </summary>
    /// <returns>XcIN</returns>
    public physValue calcXcIN()
    {
      physValue XcIN = calcXc() - calcXbacteria() - calcXmethan() - calcCOD_SX();

      XcIN.Symbol = "XcIN";

      return XcIN;
    }

    /// <summary>
    /// calc SIin, soluble inerts in input
    /// should be 0, because fSI_Xc is 0
    /// SI,in is now a substrate parameter, this method is only used
    /// when SIin is not found in xml file, maybe useful
    /// for importing old verions of xml files
    /// </summary>
    /// <returns>SIin</returns>
    public physValue calcSIin()
    {
      double fSIXc = get_param_of_d("fSI_Xc");

      physValue SIin = calcXcIN() * fSIXc;

      SIin.Symbol = "SIin";

      return SIin;
    }
        
    /// <summary>
    /// calculate particulate disintegrated COD COD_SX
    /// </summary>
    /// <returns>particulate disintegrated COD in kgCOD/m^3</returns>
    public physValue calcCOD_SX()
    {
      return calcCOD_SX(this);
    }
    /// <summary>
    /// calculate particulate disintegrated COD COD_SX
    /// </summary>
    /// <param name="mySubstrate"></param>
    /// <returns>particulate disintegrated COD in kgCOD/m^3</returns>
    public static physValue calcCOD_SX(substrate mySubstrate)
    {
      physValue[] values = new physValue[6];

      try
      {
        mySubstrate.get_params_of(out values, "COD_S", "Sva", "Sbu", "Spro", "Sac", "SIin");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error COD_SX");
      }

      physValue COD_S = values[0];
      physValue Sva = values[1];
      physValue Sbu = values[2];
      physValue Spro = values[3];
      physValue Sac = values[4];
      physValue SIin = values[5];

      return calcCOD_SX(COD_S, Sva, Sbu, Spro, Sac, SIin);
    }
    /// <summary>
    /// calculate particulate disintegrated COD COD_SX
    /// </summary>
    /// <param name="pCOD_filtrate">COD of filtrate</param>
    /// <param name="pSva">conc. of valeric acid</param>
    /// <param name="pSbu">conc. of butyric acid</param>
    /// <param name="pSpro">conc. of propionic acid</param>
    /// <param name="pSac">conc. of acetic acid</param>
    /// <param name="pSIin">soluble inerts</param>
    /// <returns>particulate disintegrated COD in kgCOD/m^3</returns>
    public static physValue calcCOD_SX(physValue pCOD_filtrate, physValue pSva, physValue pSbu, 
                                       physValue pSpro, physValue pSac, physValue pSIin)
    {
      physValue COD_filtrate = pCOD_filtrate.convertUnit("kgCOD/m^3");

      physValue Sva = pSva.convertUnit("kgCOD/m^3");
      physValue Sbu = pSbu.convertUnit("kgCOD/m^3");
      physValue Spro = pSpro.convertUnit("kgCOD/m^3");
      physValue Sac = pSac.convertUnit("kgCOD/m^3");
      physValue SIin = pSIin.convertUnit("kgCOD/m^3");

      physValue COD_SX= physValue.max(COD_filtrate - Sva - Sbu - Spro - Sac - SIin, 
        new physValue("COD_SX", 0, "kgCOD/m^3"));

      COD_SX.Symbol= "COD_SX";
      COD_SX.Label = "particulate disintegrated COD";

      return COD_SX;
    }

    

    // -------------------------------------------------------------------------------------
    //                            !!! HEAT ENERGY !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calc quantity of heat needed to heat a given amount of substrate Q
    /// to a given temperature T.
    /// </summary>
    /// <param name="Q">volumetric flow rate of substrate</param>
    /// <param name="Tend">digester temperature</param>
    /// <returns>heat energy in kWh/d</returns>
    public physValue calcQuantityOfHeatPerDay(physValue Q, physValue Tend)
    {
      return calcQuantityOfHeatPerDay(this, Q, Tend);
    }
    /// <summary>
    /// Calc quantity of heat needed to heat a given amount of substrate Q
    /// to a given temperature T.
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <param name="Q">volumetric flow rate of substrate</param>
    /// <param name="Tend">digester temperature</param>
    /// <returns>heat energy in kWh/d</returns>
    public static physValue calcQuantityOfHeatPerDay(substrate mySubstrate, 
                  physValue Q, physValue Tend)
    {
      physValue[] values= new physValue[2];

      try
      {
        mySubstrate.get_params_of(out values, "T", "c_th");
      }
      catch (exception e)
      { 
        Console.WriteLine(e.Message);
        return new physValue("error qh");
      }

      physValue T_substrate= values[0];
      physValue c_th=        values[1];

      return mySubstrate.calcQuantityOfHeatPerDay(Q, T_substrate, c_th, Tend);
    }
    /// <summary>
    /// Calc quantity of heat needed to heat a given amount of substrate Q
    /// to a given temperature Tend, starting at the temperature T_substrate.
    /// </summary>
    /// <param name="pQ">Q of substrate</param>
    /// <param name="pT_substrate">Temperature of substrate</param>
    /// <param name="pc_th">heat capacity of substrate</param>
    /// <param name="pTend">digester Temperature</param>
    /// <returns>heat energy in kWh/d</returns>
    public physValue calcQuantityOfHeatPerDay(physValue pQ, 
                                              physValue pT_substrate,
                                              physValue pc_th,
                                              physValue pTend)
    {
      physValue Q=           pQ.convertUnit("m^3/d");
      physValue Tend=        pTend.convertUnit("°C");
      physValue T_substrate= pT_substrate.convertUnit("°C");
      physValue c_th=        pc_th.convertUnit("kWh/(m^3 * K)");

      // In Ganzheitliche stoffliche und energetische Modellierung S. 55
      // wird gezeigt wie stark Substrattemperatur von Außentemperatur abhängig
      // ist. bspw. hängt gülletemp. fast linear mit außentemperatur
      // zusammen, wobei maissilage auch im winter und Sommer bei 20 °C liegt. 

      // P_{substrate,heat}(t) [kWh/d]= Q_{liq}(t) * c_{th} * 
      // ( T_{digester} - T_{outside} )
      //
      // [ kWh/d ]=[ m^3/d * kWh/(m^3 * K) * K ]
      //
      // Achtung: es ist total falsch eine temperaturdifferenz im nachhinein
      // in Kelvin zu konvertieren. vorher beide temperaturen in Kelvin
      // dann differenz bilden
      //
      physValue Qtherm_day = Q * (Tend.convertUnit("K") - T_substrate.convertUnit("K")) * c_th;

      return Qtherm_day;
    }



    // -------------------------------------------------------------------------------------
    //                            !!! TS AND Xc !!!
    // -------------------------------------------------------------------------------------

    ///// <summary>
    ///// Calculates the TS content of the substrate in % FM
    ///// 
    ///// As a reference see:
    ///// 
    ///// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    ///// Biogas from grass silage – Measurements and modeling with ADM1, 
    ///// Bioresource Technology 101, pp. 8158-8165, 2010.
    ///// 
    ///// </summary>
    ///// <returns></returns>
    //public physValue calcTS()
    //{
    //  return calcTS(this);
    //}
    ///// <summary>
    ///// Calculates the TS content of the substrate in % FM
    ///// </summary>
    ///// <param name="mySubstrate"></param>
    ///// <returns></returns>
    //public static physValue calcTS(substrate mySubstrate)
    //{
    //  physValue[] values= new physValue[7];

    //  mySubstrate.get_params_of(out values, "RF", "RP", "RL", 
    //                                        "ADL", "VS", "COD", "rho");

    //  physValue RF=  values[0];
    //  physValue RP=  values[1];
    //  physValue RL=  values[2];
    //  physValue ADL= values[3];
    //  physValue VS=  values[4];
    //  physValue COD= values[5];
    //  physValue rho= values[6];

    //  return calcTS(RF, RP, RL, ADL, VS, COD, rho);
    //}
    /// <summary>
    /// Calculates the TS content of the substrate in % FM
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <param name="COD">particulate COD only, must be measured in kgCOD/m^3</param>
    /// <param name="rho">must be measured in kg/m^3</param>
    /// <returns>TS</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValue calcTS(double RF, double RP, double RL,
                                   double ADL, double VS, double COD,
                                   double rho)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pVS = new science.physValue("VS", VS, "% TS");
      physValue pCOD = new science.physValue("COD", COD, "kgCOD/m^3");
      physValue prho = new science.physValue("rho", rho, "kg/m^3");

      return calcTS(pRF, pRP, pRL, pADL, pVS, pCOD, prho);
    }
    /// <summary>
    /// Calculates the TS content of the substrate in % FM
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pVS">volatile solids</param>
    /// <param name="pCOD">particulate COD only</param>
    /// <param name="prho">density of substrate</param>
    /// <returns>TS</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValue calcTS(physValue pRF, physValue pRP, physValue pRL,
                                   physValue pADL, physValue pVS, physValue pCOD,
                                   physValue prho)
    {
      physValue COD, rho;

      try
      {
        COD = pCOD.convertUnit("kgCOD/m^3");
        rho = prho.convertUnit("kg/m^3");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValue("error TS");
      }

      // get the theoretical chemical oxygen demand for the basic molecules
      physValue ThODch = biogas.chemistry.ThODch;
      physValue ThODpr = biogas.chemistry.ThODpr;
      physValue ThODli = biogas.chemistry.ThODli;
      physValue ThODl = biogas.chemistry.ThODl;

      // calc nitrogen-free extract of the substrate
      physValue pNfE = calcNfE(pRF, pRP, pRL, pVS);

      // all numbers are given in % TS, 
      // divide by 100 % TS to get them in 100 %, thus unitless

      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue ADL = pADL.convertUnit("100 %");

      //

      physValueBounded TS;

      // calc TS of composites as in the given reference
      // COD (Xc) is measured in [gCOD/l] respectively [kgCOD/m^3] as in the ADMs
      // As the values RP, RL, ADL, ... are measured in [100 % TS] the weighted
      // sum is multiplied with TS. The values ThODpr are measured in [gCOD/g], so
      // we have to multiply with rho (measured in [g/l]) to get [kgCOD/m^3]

      if (RP * ThODpr +  // proteins
           RL * ThODli +  // lipids
          ADL * ThODl +  // lignin
          (RF + NfE - ADL) * ThODch !=
          new science.physValue(0, "gCOD/g")
         )
        TS = new physValueBounded
           (COD / rho *
             new science.physValue(1, "kg*gCOD/(g*kgCOD)") /
             (
               RP * ThODpr +  // proteins
               RL * ThODli +  // lipids
              ADL * ThODl +  // lignin
              (RF + NfE - ADL) * ThODch // carbohydrates - lignin
             )
           );

      else
        TS = new science.physValueBounded("TS", 0, "100 %");

      //

      TS = TS.convertUnit("% FM");

      TS.Symbol = "TS";

      //

      TS.setBounds(0, 100);

      TS.printIsOutOfBounds();

      return (physValue)TS;
    }

    /// <summary>
    /// Calculates the particulate COD content of the substrate in kgCOD/m^3
    /// 
    /// As a reference see:
    /// 
    /// Koch, K., Lübken, M., Gehring, T., Wichern, M., and Horn, H.: 
    /// Biogas from grass silage – Measurements and modeling with ADM1, 
    /// Bioresource Technology 101, pp. 8158-8165, 2010.
    /// 
    /// </summary>
    /// <returns>particulate COD</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public physValueBounded calcXc()
    {
      return calcXc(this);
    }
    /// <summary>
    /// Calculates the particulate COD content of the substrate in kgCOD/m^3
    /// </summary>
    /// <param name="mySubstrate"></param>
    /// <returns>particulate COD</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValueBounded calcXc(substrate mySubstrate)
    {
      physValue[] values= new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS", "rho");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error Xc");
      }

      physValue RF=  values[0];
      physValue RP=  values[1];
      physValue RL=  values[2];
      physValue ADL= values[3];
      physValue VS=  values[4];
      physValue TS=  values[5];
      physValue rho= values[6];

      return calcXc(RF, RP, RL, ADL, VS, TS, rho);
    }
    /// <summary>
    /// Calculates the particulate COD content of the substrate in kgCOD/m^3
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <param name="rho">must be measured in kg/m^3</param>
    /// <returns>particulate COD</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValueBounded calcXc(double RF, double RP, double RL,
                                          double ADL, double VS, double TS,
                                          double rho)
    {
      physValue pRF=  new science.physValue("RF",  RF,  "% TS");
      physValue pRP=  new science.physValue("RP",  RP,  "% TS");
      physValue pRL=  new science.physValue("RL",  RL,  "% TS");
      physValue pADL= new science.physValue("ADL", ADL, "% TS");
      physValue pVS=  new science.physValue("VS",  VS,  "% TS");
      physValue pTS=  new science.physValue("TS",  TS,  "% FM");
      physValue prho= new science.physValue("rho", rho, "kg/m^3");

      return calcXc(pRF, pRP, pRL, pADL, pVS, pTS, prho);
    }
    /// <summary>
    /// Calculates the COD content of the substrate in kgCOD/m^3
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pVS">volatile solids</param>
    /// <param name="pTS">total solids</param>
    /// <param name="prho">density of substrate</param>
    /// <returns>particulate COD</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValueBounded calcXc(physValue pRF, physValue pRP, physValue pRL,
                                          physValue pADL, physValue pVS, physValue pTS,
                                          physValue prho)
    {
      physValue TS, rho;
  
      try
      {
        TS= pTS.convertUnit("% FM");
        rho= prho.convertUnit("kg/m^3");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error Xc");
      }

      // get the theoretical chemical oxygen demand for the basic molecules
      physValue ThODch= biogas.chemistry.ThODch;
      physValue ThODpr= biogas.chemistry.ThODpr;
      physValue ThODli= biogas.chemistry.ThODli;
      physValue ThODl=  biogas.chemistry.ThODl;

      // calc nitrogen-free extract of the substrate
      physValue pNfE= calcNfE(pRF, pRP, pRL, pVS);

      // all numbers are given in % FM respectively % TS, 
      // divide by 100 % FM respectively % TS to get them in 100 %, thus unitless

      TS= TS.convertUnit("100 %");

      physValue RF=   pRF.convertUnit("100 %");
      physValue RP=   pRP.convertUnit("100 %");
      physValue RL=   pRL.convertUnit("100 %");
      physValue NfE= pNfE.convertUnit("100 %");
      physValue ADL= pADL.convertUnit("100 %");

      // calc COD of composites as in the given reference
      // Xc is measured in [gCOD/l] respectively [kgCOD/m^3] as in the ADMs
      // As the values RP, RL, ADL, ... are measured in [100 % TS] the weighted
      // sum is multiplied with TS. The values ThODpr are measured in [gCOD/g], so
      // we have to multiply with rho (measured in [g/l]) to get [kgCOD/m^3]

      physValueBounded Xc=  new physValueBounded(rho * TS * 
                     new science.physValue(1, "g*kgCOD/(kg*gCOD)") *(
                      RP * ThODpr +  // proteins
                      RL * ThODli +  // lipids
                     ADL * ThODl  +  // lignin
                     (RF + NfE - ADL) * ThODch // carbohydrates - lignin
                                ) );

      //

      Xc.Symbol= "Xc";

      //

      Xc.setLB(0);

      Xc.printIsOutOfBounds();

      return Xc;
    }



    /// <summary>
    /// Calculates the TOC content of the substrate in kgTOC/m^3
    /// 
    /// As a reference see:
    /// 
    /// U. Zaher: Modelling and Monitoring the AD process in view of optimisation 
    /// and smooth operation, diss. uni Gent, 2005.
    /// p. 19
    /// 
    /// </summary>
    /// <returns>TOC in kgTOC/m^3 FM</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public physValueBounded calcTOC()
    {
      return calcTOC(this);
    }
    /// <summary>
    /// Calculates the TOC content of the substrate in kgTOC/m^3
    /// </summary>
    /// <param name="mySubstrate">a substrate</param>
    /// <returns>TOC in kgTOC/m^3 FM</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValueBounded calcTOC(substrate mySubstrate)
    {
      physValue[] values = new physValue[7];

      try
      {
        mySubstrate.get_params_of(out values, "RF", "RP", "RL",
                                              "ADL", "VS", "TS", "rho");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error TOC");
      }

      physValue RF = values[0];
      physValue RP = values[1];
      physValue RL = values[2];
      physValue ADL = values[3];
      physValue VS = values[4];
      physValue TS = values[5];
      physValue rho = values[6];

      return calcTOC(RF, RP, RL, ADL, VS, TS, rho);
    }
    /// <summary>
    /// Calculates the TOC content of the substrate in kgTOC/m^3
    /// </summary>
    /// <param name="RF">must be measured in % TS</param>
    /// <param name="RP">must be measured in % TS</param>
    /// <param name="RL">must be measured in % TS</param>
    /// <param name="ADL">must be measured in % TS</param>
    /// <param name="VS">must be measured in % TS</param>
    /// <param name="TS">must be measured in % FM</param>
    /// <param name="rho">must be measured in kg/m^3</param>
    /// <returns>TOC in kgTOC/m^3 FM</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValueBounded calcTOC(double RF, double RP, double RL,
                                           double ADL, double VS, double TS,
                                           double rho)
    {
      physValue pRF = new science.physValue("RF", RF, "% TS");
      physValue pRP = new science.physValue("RP", RP, "% TS");
      physValue pRL = new science.physValue("RL", RL, "% TS");
      physValue pADL = new science.physValue("ADL", ADL, "% TS");
      physValue pVS = new science.physValue("VS", VS, "% TS");
      physValue pTS = new science.physValue("TS", TS, "% FM");
      physValue prho = new science.physValue("rho", rho, "kg/m^3");

      return calcTOC(pRF, pRP, pRL, pADL, pVS, pTS, prho);
    }
    /// <summary>
    /// Calculates the TOC content of the substrate in kgTOC/m^3 FM
    /// </summary>
    /// <param name="pRF">raw fiber</param>
    /// <param name="pRP">raw protein</param>
    /// <param name="pRL">raw lipids</param>
    /// <param name="pADL">acid detergent lignin</param>
    /// <param name="pVS">volatile solids</param>
    /// <param name="pTS">total solids</param>
    /// <param name="prho">density of substrate</param>
    /// <returns>TOC in kgTOC/m^3 FM</returns>
    /// <exception cref="exception">Value out of bounds</exception>
    public static physValueBounded calcTOC(physValue pRF, physValue pRP, physValue pRL,
                                           physValue pADL, physValue pVS, physValue pTS,
                                           physValue prho)
    {
      physValue TS, rho;
  
      try
      {
        TS= pTS.convertUnit("% FM");
        rho = prho.convertUnit("kg/m^3");
      }
      catch (exception e)
      {
        Console.WriteLine(e.Message);
        return new physValueBounded("error TOC");
      }

      // get the total organic carbon content in g/g for the basic molecules
      physValue TOCch = biogas.chemistry.calcTOC("Xch");
      physValue TOCpr = biogas.chemistry.calcTOC("Xpr");
      physValue TOCli = biogas.chemistry.calcTOC("Xli");
      physValue TOCl = biogas.chemistry.calcTOC("Lignin");

      // calc nitrogen-free extract of the substrate
      physValue pNfE = calcNfE(pRF, pRP, pRL, pVS);

      // all numbers are given in % FM respectively % TS, 
      // divide by 100 % FM respectively % TS to get them in 100 %, thus unitless

      TS = TS.convertUnit("100 %");

      physValue RF = pRF.convertUnit("100 %");
      physValue RP = pRP.convertUnit("100 %");
      physValue RL = pRL.convertUnit("100 %");
      physValue NfE = pNfE.convertUnit("100 %");
      physValue ADL = pADL.convertUnit("100 %");

      physValueBounded TOC = new physValueBounded(rho * TS *
                     new science.physValue(1, "kgTOC/kg") * (
                      RP * TOCpr +  // proteins
                      RL * TOCli +  // lipids
                     ADL * TOCl +  // lignin
                     (RF + NfE - ADL) * TOCch // carbohydrates - lignin
                                ));

      //

      TOC.Symbol = "TOC";

      //

      TOC.setLB(0);

      TOC.printIsOutOfBounds();

      return TOC;
    }



    // -------------------------------------------------------------------------------------
    //                          !!! VOLATILE SOLIDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculates the volatile solids content out of TS and ash, measured in % TS
    /// </summary>
    /// <param name="TS">must be measured in % FM</param>
    /// <param name="ash">must be measured in % FM</param>
    /// <returns></returns>
    public static physValueBounded calcVS(double TS, double ash)
    {
      physValue pTS=  new science.physValue("TS",  TS,  "% FM");
      physValue pash= new science.physValue("ash", ash, "% FM");

      return calcVS(pTS, pash);
    }
    /// <summary>
    /// Calculates the volatile solids content out of TS and ash, measured in % TS
    /// </summary>
    /// <param name="pTS"></param>
    /// <param name="pash"></param>
    /// <returns></returns>
    public static physValueBounded calcVS(physValue pTS, physValue pash)
    {
      physValue TS= pTS.convertUnit("% FM");
      physValue ash= convertFrom_TS_To_FM(pash, TS);

      // if ash was not measured in % TS, then convert here to % FM
      ash= ash.convertUnit("% FM");
      
      physValueBounded VS= new physValueBounded( 
                           new physValue(100, "% TS") - 
                           (ash / TS).convertUnit("% TS") );

      VS.Symbol= "VS";

      VS.setBounds(0, 100);
      
      VS.printIsOutOfBounds();

      return VS;
    }

    

  }
}


