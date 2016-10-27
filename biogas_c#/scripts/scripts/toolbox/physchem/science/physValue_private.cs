/**
 * This file is part of the partial class physValue and defines
 * private methods.
 * 
 * TODOs:
 * - check the method reduceFraction()
 * - delete TAC in list below
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using toolbox;
using System.Text;
using System.Collections;

/**
 * The science namespace collects all classes which have to do with science in general.
 * 
 */
namespace science
{
  /// <remarks>
  /// Defines a physical value, which is a double number containing a unit and a symbol.
  /// Furthermore a label describes the physical value.
  /// There are operators implemented, such that you can add, substract, multiply, ...
  /// physical values.
  /// Working with physical values assures that you do not get wrong with units
  /// and always know in which unit the value is measured. This is realised by checking
  /// the unit while adding and substracting and reduce the fraction when multiplying
  /// and dividing physical values. Furthermore you can convert units.
  /// 
  /// You can define a reference for the physical value, e.g. when you save a number 
  /// which you have from literature or a database.
  /// 
  /// All methods in this class are const, as defined in C++, except stated otherwise
  /// 
  /// </remarks>
  public partial class physValue
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Reduces the fraction of the numerator / denominator
    /// </summary>
    /// <param name="numerator">
    /// 2dim string vector, 1st comp. numerator for first physValue and 2nd
    /// for 2nd physValue</param>
    /// <param name="denominator">
    /// 2dim string vector, 1st comp. denominator for first physValue and 2nd
    /// for 2nd physValue</param>
    /// <returns></returns>
    private static string reduceFraction(string[] numerator,
                                         string[] denominator) // const
    {
      // maybe numerator and denominator could also have more then 2 dimensions???
      int n_num= numerator.Length;
      int n_denom= denominator.Length;

      //
      string unit= "";

      //

      ArrayList numerator_el= new ArrayList();
            
      for (int inum= 0; inum < n_num; inum++) // for each numerator
      {
        string[] result= numerator[inum].Split('*');

        for (int ii= 0; ii < result.Length; ii++)
        {
          result[ii]= result[ii].Trim();
        
          numerator_el.Add(result[ii]); // contains all elements of the numerator
        }
      }

      //

      ArrayList denominator_el= new ArrayList();

      for (int inum= 0; inum < n_denom; inum++)
      {
        string[] result= denominator[inum].Split('*');

        for (int ii= 0; ii < result.Length; ii++)
        {
          result[ii]= result[ii].Replace("(", " ");
          result[ii]= result[ii].Replace(")", " ");
          
          result[ii]= result[ii].Trim();

          denominator_el.Add(result[ii]); // contains all elements of the denominator
        }
      }

      //

      while( numerator_el.Contains("100 %") || numerator_el.Contains("1") )
      {
        numerator_el.Remove("100 %");
        numerator_el.Remove("1");
      }

      while ( denominator_el.Contains("100 %") || denominator_el.Contains("1") )
      {
        denominator_el.Remove("100 %");
        denominator_el.Remove("1");
      }

      //

      int inum2= 0;
      
      while( inum2 < numerator_el.Count )
      {
        int idenum= 0;

        while( idenum < denominator_el.Count )
        { // kürzen des Bruchs
          if (String.Compare(  numerator_el[inum2].ToString(), 
                             denominator_el[idenum].ToString()) == 0)
          {
            numerator_el.RemoveAt(inum2);
            denominator_el.RemoveAt(idenum);

            inum2= inum2 - 1;

            break;
          }

          idenum= idenum + 1;
        }

        inum2= inum2 + 1;
      }

      //
      // alles weggekürzt -> d.h. Einheitenlos
      if ( numerator_el.Count == 0 && denominator_el.Count == 0 )
      {
        unit= "100 %";
        return unit;
      }
      else if ( numerator_el.Count == 0 )
      {  
        // 1/(...)
        numerator_el.Add("1");
      }

      //

      string numerator_s= numerator_el[0].ToString();

      for (int inum= 1; inum < numerator_el.Count; inum++)
      {
        numerator_s= numerator_s + " * " + numerator_el[inum].ToString();
      }

      //

      if (denominator_el.Count > 0)
      {

        string denominator_s= denominator_el[0].ToString();

        for (int inum= 1; inum < denominator_el.Count; inum++)
        {
          denominator_s= denominator_s + " * " + denominator_el[inum].ToString();
        }

        if (denominator_el.Count > 1)
          unit= String.Format("{0}/({1})", numerator_s, denominator_s);
        else
          unit= String.Format("{0}/{1}", numerator_s, denominator_s);
      }
      else 
      {
        unit= numerator_s;
      }

      //

      return unit;
    }

    /// <summary>
    /// Returns the label and unit belonging to the given symbol
    /// </summary>
    /// <param name="symbol">Symbol of the physValue</param>
    /// <param name="label">label that belongs to the given symbol</param>
    /// <param name="unit">unit that belongs to the given symbol</param>
    /// <returns>true on success, else false</returns>
    private static bool getLabelAndUnit(string symbol, out string label,
                                        out string unit) // const
    {
      bool found= true;
    
      switch (symbol)
      { 
        //                    ***** chemistry *****
           
        case "M_C":
          label= "molar mass of Carbon";
          unit=  "g/mol"; break;
        case "M_H":
          label= "molar mass of Hydrogen";
          unit=  "g/mol"; break;
        case "M_O":
          label= "molar mass of Oxygen";
          unit=  "g/mol"; break;
        case "M_N":
          label= "molar mass of Nitrogen";
          unit=  "g/mol"; break;
        case "M_S":
          label= "molar mass of Sulfur";
          unit=  "g/mol"; break;

        //                    ***** ADM state vector components *****
        
        case "Ssu":
          label= "monosaccarides";
          unit=  "kgCOD/m^3"; break;
        case "Saa":
          label= "amino acids";
          unit=  "kgCOD/m^3"; break;
        case "Sfa":
          label= "long chain fatty acids";
          unit=  "kgCOD/m^3"; break;

        //
        case "Sh2":
          label= "soluble molecular hydrogen";    // TODO: bezeichnung evtl. nicht ganz richtig: molecular?
          unit=  "kgCOD/m^3"; break;
        case "Sch4":
          label= "soluble methane";
          unit=  "kgCOD/m^3"; break;
        case "Sco2":
          label= "soluble carbon dioxide";
          unit=  "kmol/m^3"; break;
        case "Shco3":
          label= "bicarbonate";
          unit=  "kmol/m^3"; break;

        //
        case "Snh3":
          label= "soluble ammonia";
          unit=  "kmol/m^3"; break;
        case "Snh4":
          label= "soluble ammonium";
          unit=  "kmol/m^3"; break;

        //
        case "Sac":
        case "Shac + Sac_":
        case "Sac_ + Shac":
          label= "acetic acid + acetate";
          unit=  "kgCOD/m^3"; break;
        case "Shac":
          label= "acetic acid";
          unit= "kgCOD/m^3"; break;
        case "Sac_":
          label= "acetate";
          unit= "kgCOD/m^3"; break;
        
        //
        case "Spro": 
        case "Shpro + Spro_": 
        case "Spro_ + Shpro":
          label= "propionic acid + propionate";
          unit=  "kgCOD/m^3"; break;
        case "Shpro":
          label= "propionic acid";
          unit=  "kgCOD/m^3"; break;
        case "Spro_":
          label= "propionate";
          unit=  "kgCOD/m^3"; break;
          
        //
        case "Sbu":
        case "Shbu + Sbu_":
        case "Sbu_ + Shbu":
          label= "butyric acid + butyrate";
          unit=  "kgCOD/m^3"; break;
        case "Shbu":
          label= "butyric acid";
          unit=  "kgCOD/m^3"; break;
        case "Sbu_":
          label= "butyrate";
          unit=  "kgCOD/m^3"; break;
        
        //
        case "Sva":
        case "Shva + Sva_": 
        case "Sva_ + Shva":
          label= "valeric acid + valerate";
          unit=  "kgCOD/m^3"; break;
        case "Shva":
          label= "valeric acid";
          unit=  "kgCOD/m^3"; break;
        case "Sva_":
          label= "valerate";
          unit=  "kgCOD/m^3"; break;
          
        //
        case "Xc":
          label= "composites in need for disintegration";
          unit=  "kgCOD/m^3"; break;
        case "Xbio":
          label= "biomass";
          unit=  "kgCOD/m^3"; break;
          
        case "SI":
          label= "soluble inerts";
          unit=  "kgCOD/m^3"; break;
        case "Xch":
          label= "carbohydrates";
          unit=  "kgCOD/m^3"; break;
        case "Xpr":
          label= "proteins";
          unit=  "kgCOD/m^3"; break;
        case "Xli":
          label= "lipids";
          unit=  "kgCOD/m^3"; break;
        case "Xsu":
          label= "biomass sugar degraders";
          unit=  "kgCOD/m^3"; break;
        case "Xaa":
          label= "biomass amino acid degraders";
          unit=  "kgCOD/m^3"; break;
        case "Xfa":
          label= "biomass long chain fatty acid degraders";
          unit=  "kgCOD/m^3"; break;
        case "Xc4":
          label= "biomass valerate and butyrate degraders";   
          unit=  "kgCOD/m^3"; break;
        case "Xpro":
          label= "biomass propionic acid";
          unit=  "kgCOD/m^3"; break;
        case "Xac":
          label= "biomass acetic acid";
          unit=  "kgCOD/m^3"; break;
        case "Xh2":
          label= "biomass hydrogen degraders"; 
          unit=  "kgCOD/m^3"; break;
        case "XI":
          label= "particulate inerts";
          unit=  "kgCOD/m^3"; break;
        case "Xp":
          label= "particulate products biomass decay"; 
          unit=  "kgCOD/m^3"; break;
        case "Scat":
          label= "cations";
          unit=  "kmol/m^3"; break;   // stimmt die Einheit? Ja
        case "San":
          label= "anions";
          unit=  "kmol/m^3"; break;   // stimmt die Einheit? ja

        case "piSh2":
          label= "partial pressure molecular hydrogen";
          unit=  "bar"; break;
        case "piSch4":
          label= "partial pressure methane";
          unit=  "bar"; break;
        case "piSco2":
          label= "partial pressure carbon dioxide";
          unit=  "bar"; break;
        case "pTOTAL":
          label= "total pressure";
          unit=  "bar"; break;
          
        //                    ***** substrate characterisation *****

        case "RF":
          label= "raw fiber (Rohfaser)";
          unit=  "% TS"; break;
        case "RP":
          label= "raw protein (Rohprotein)";
          unit=  "% TS"; break;
        case "RL":
          label= "raw lipids (Rohfett)";
          unit=  "% TS"; break;
        case "NDF":
          label= "neutral detergent fiber";
          unit=  "% TS"; break;
        case "ADF":
          label= "acid detergent fiber";
          unit=  "% TS"; break;
        case "ADL":
          label= "acid detergent lignin";
          unit=  "% TS"; break;

        case "NfE":
          label= "nitrogen-free extract";
          unit=  "% TS"; break;
        case "Cell":
          label= "cellulose";
          unit=  "% TS"; break;
        case "HemCell":
          label= "hemicellulose";
          unit=  "% TS"; break;
        case "NFC":
          label= "non-fibre carbohydrates";
          unit= "% TS"; break;
        case "TKN":
          label= "total Kjeldahl nitrogen";
          unit= "% TS"; break;

        case "TOC":   // TODO: check if unit is correct
          label= "Total Organic Carbon";
          unit= "mg/l"; break;

        case "pH":
          label= "pH value";
          unit=  "-"; break;
        
        case "c_th":            // Tipler: spezifische Wärme
          label= "specific heat capacity (specific heat)";
          unit=  "kJ/(kg * K)"; break;
        case "T":
          label= "temperature";
          unit=  "°C"; break;
            
        //                    ***** measurements *****

        case "FOS_TAC":
          label= "VFA/TA";   // sollte man evtl. VFA/TA nennen, FOS/TAC, alt
          //description= "volatile fatty acids / total alcalic carbonate";
          unit=  "gHAceq/gCaCO3eq"; break;
        case "Svfa":
          label= "volatile fatty acids";
          unit=  "gHAceq/l"; break;
        case "TAC":     // TODO: sollte man löschen, ist TA
          label = "total alkalinity"; //label = "total alcalic carbonate";
          unit = "gCaCO3eq/l"; break; // a part of that is Carbonate alkalinity
        case "TA":     // 
          label = "total alkalinity"; //label = "total alcalic carbonate";
          unit = "gCaCO3eq/l"; break; // a part of that is Carbonate alkalinity
          
        case "HRT":
          label= "hydraulic retention time";
          unit=  "d"; break;
        case "SRT":
          label= "sludge retention time";
          unit=  "d"; break;
        case "OLR":
          label= "organic loading rate";
          unit=  "kg/(d * m^3)"; break;
        case "rho":
          label= "density";
          unit=  "kg/m^3"; break;

        case "cost":
          label= "cost";
          unit=  "€/m^3"; break;

        case "COD":
          label= "total chemical oxygen demand";
          unit=  "kgCOD/m^3"; break;
        case "COD_S":
          label= "chemical oxygen demand of filtrate";
          unit=  "kgCOD/m^3"; break;

        case "SS_COD":
          label= "soluble solids (sum of all COD containing soluble components)";
          unit=  "kgCOD/m^3"; break;
        case "VS_COD":
          label= "volatile solids (sum of all particulate COD containing components)";
          unit=  "kgCOD/m^3"; break;
          
        case "VS":
          label= "volatile solids";
          unit= "% TS"; break;
        case "TS":
          label= "total solids (VS + Ash)";
          unit= "% FM"; break; // Fresh Matter
        case "D_VS":
          label= "degradation level";
          unit= "100 %"; break;

        case "Ash":
          label= "ash";
          unit= "% TS"; break; // Total Solids
           
        //                    ***** energy *****

        case "Hch4":
          label= "calorific value of methane";
          unit= "kWh/m^3"; break;
        case "Hh2":
          label= "calorific value of molecular hydrogen";
          unit= "kWh/m^3"; break;


        case "Pel":
          label = "electrical power";
          unit = "kW"; break;
        case "Ptherm":
          label = "thermal power";
          unit = "kW"; break;

        //                    ***** digester *****

        case "Vtot":
          label= "total volume of the digester";
          unit= "m^3"; break;
        case "Vliq":
          label= "liquid volume of the digester";
          unit= "m^3"; break;
        case "Vgas":
          label= "volume of the gas space of the digester";
          unit= "m^3"; break;

        case "Atot":
          label= "total surface of the digester";
          unit= "m^2"; break;
        // heat transfer coefficient of the fermenter
        // study the effect of Wärmedämmung and different materials
        // habe ich gemacht
        case "h_th":    // http://en.wikipedia.org/wiki/Heat_transfer_coefficient
          label= "heat transfer coefficient";
          unit=  "W/(m^2 * K)"; break;

        //                    ***** plant *****

        case "g":
          label= "gravitational acceleration";
          unit=  "m/s^2"; break;

        //                    ***** biogas *****

        case "Qgas":
          label= "volumetric flow rate total biogas (h2 + ch4 + co2)";
          unit= "m^3/d"; break;
        case "Qgas_h2":
          label = "volumetric flow rate of hydrogen";
          unit= "m^3/d"; break;
        case "Qgas_ch4":
          label = "volumetric flow rate of methane";
          unit= "m^3/d"; break;
        case "Qgas_co2":
          label = "volumetric flow rate of carbon dioxide";
          unit= "m^3/d"; break;

        //                    ***** ADM Parameters *****

        case "kdis":
          label= "disintegration rate";
          unit= "1/d"; break;
        case "khyd_ch":
          label= "hydrolysis rate carbohydrates";
          unit= "1/d"; break;
        case "khyd_pr":
          label= "hydrolysis rate proteins";
          unit= "1/d"; break;
        case "khyd_li":
          label= "hydrolysis rate lipids";
          unit= "1/d"; break;

        //
        default:
          found= false;
          label= "";
          unit= ""; break;
      }

      return found;
    }


    
  }
}


