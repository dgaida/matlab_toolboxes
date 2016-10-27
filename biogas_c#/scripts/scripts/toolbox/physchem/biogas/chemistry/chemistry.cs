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
* This file is part of the partial class chemistry and contains
* the rest of the class, which is not located in seperate files.
* 
* TODOs:
* - see TODO in file, but not important
* 
* FINISHED!
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
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns g C in molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g C / molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_C_mass_of(string molecule)
    {
      physValue C;

      // mol C / molecule
      biogas.chemistry.get_C_of(molecule, out C);

      // g / molecule
      return C * biogas.chemistry.mol_mass_C;
    }

    /// <summary>
    /// Returns g H in molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g H / molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_H_mass_of(string molecule)
    {
      physValue H;

      // mol H / molecule
      biogas.chemistry.get_H_of(molecule, out H);

      // g / molecule
      return H * biogas.chemistry.mol_mass_H;
    }

    /// <summary>
    /// Returns g O in molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g O / molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_O_mass_of(string molecule)
    {
      physValue O;

      // mol O / molecule
      biogas.chemistry.get_O_of(molecule, out O);

      // g / molecule
      return O * biogas.chemistry.mol_mass_O;
    }

    /// <summary>
    /// Returns g N in molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g N / molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_N_mass_of(string molecule)
    {
      physValue N;

      // mol N / molecule
      biogas.chemistry.get_N_of(molecule, out N);

      // g / molecule
      return N * biogas.chemistry.mol_mass_N;
    }

    /// <summary>
    /// Returns g S in molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g S / molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_S_mass_of(string molecule)
    {
      physValue S;

      // mol S / molecule
      biogas.chemistry.get_S_of(molecule, out S);

      // g / molecule
      return S * biogas.chemistry.mol_mass_S;
    }

    /// <summary>
    /// Returns g C / g molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g C / g molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">division by zero</exception>
    public static physValue get_C_rel_mass_of(string molecule)
    {
      // g C / molecule
      physValue C= biogas.chemistry.get_C_mass_of(molecule);

      // g C / molecule / (g / molecule) = g C / g
      return C / biogas.chemistry.get_mol_mass_of(molecule);
    }

    /// <summary>
    /// Returns g H / g molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g H / g molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">division by zero</exception>
    public static physValue get_H_rel_mass_of(string molecule)
    {
      // g H / molecule
      physValue H = biogas.chemistry.get_H_mass_of(molecule);

      // g H / molecule / (g / molecule) = g H / g
      return H / biogas.chemistry.get_mol_mass_of(molecule);
    }

    /// <summary>
    /// Returns g O / g molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g O / g molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">division by zero</exception>
    public static physValue get_O_rel_mass_of(string molecule)
    {
      // g O / molecule
      physValue O = biogas.chemistry.get_O_mass_of(molecule);

      // g O / molecule / (g / molecule) = g O / g
      return O / biogas.chemistry.get_mol_mass_of(molecule);
    }

    /// <summary>
    /// Returns g N / g molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g N / g molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">division by zero</exception>
    public static physValue get_N_rel_mass_of(string molecule)
    {
      // g N / molecule
      physValue N = biogas.chemistry.get_N_mass_of(molecule);

      // g N / molecule / (g / molecule) = g N / g
      return N / biogas.chemistry.get_mol_mass_of(molecule);
    }

    /// <summary>
    /// Returns g S / g molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>g S / g molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">division by zero</exception>
    public static physValue get_S_rel_mass_of(string molecule)
    {
      // g S / molecule
      physValue S = biogas.chemistry.get_S_mass_of(molecule);

      // g S / molecule / (g / molecule) = g S / g
      return S / biogas.chemistry.get_mol_mass_of(molecule);
    }

    /// <summary>
    /// Returns the molar mass of the given molecule in g/mol.
    /// The molar mass of the molecule is calculated out of the molar masses of
    /// C, H, O, N and S
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>molar mass in g/mol of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_mol_mass_of(string molecule)
    {
      physValue c;
      physValue h;
      physValue o;
      physValue n;
      physValue s;

      get_CHONS_of(molecule, out c, out h, out o, out n, out s);

      physValue mol_mass;

      mol_mass= c * biogas.chemistry.mol_mass_C + 
                h * biogas.chemistry.mol_mass_H + 
                o * biogas.chemistry.mol_mass_O + 
                n * biogas.chemistry.mol_mass_N + 
                s * biogas.chemistry.mol_mass_S;

      mol_mass.Symbol= String.Format("M_{0}", molecule);
      mol_mass.Label=  String.Format("molar mass of {0}", molecule);

      return mol_mass;
    }
    
    /// <summary>
    /// Calculates the Chemical Oxygen Demand for the given molecule in gCOD/mol.
    /// useSwitch is set to true
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>COD of molecule in gCOD/mol</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_COD_of(string molecule)
    {
      return get_COD_of(molecule, true);
    }
    /// <summary>
    /// Calculates the Chemical Oxygen Demand for the given molecule in gCOD/mol.
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="useSwitch">if true, then use precalculated values or calculate
    /// COD of methane. Only valid for the following molecules:
    /// different VFAs (Sac, Shac, Sac_, Spro, ...) and Sch4</param>
    /// <returns>COD in gCOD/mol of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_COD_of(string molecule, bool useSwitch)
    {
      physValue COD;

      // these values are calculated very often, so they are precalculated and returned.
      if (useSwitch)
      {
        switch (molecule)
        {
          case "Sac":
          case "Shac":
          case "Sac_":
            return COD_Sac;
          case "Spro":
          case "Shpro":
          case "Spro_":
            return COD_Spro;
          case "Sbu":
          case "Shbu":
          case "Sbu_":
            return COD_Sbu;
          case "Sva":
          case "Shva":
          case "Sva_":
            return COD_Sva;

          case "Sch4":
            physValue c_ch4;
            physValue h_ch4;
            physValue o_ch4;
            physValue n_ch4;

            // get number of c and h atoms in 1 mol ch4
            get_CHON_of("Sch4", out c_ch4, out h_ch4, out o_ch4, out n_ch4);

            physValue o2_burn_ch4;

            // number of mols o2 needed to burn 1 mol ch4
            combust(c_ch4, h_ch4, o_ch4, n_ch4, out o2_burn_ch4);

            // g O to burn 1 mol ch4, defined as gCOD ch4
            // since we are talking about combustion the weight of oxygen is not
            // measured in g but in gCOD
            // factor 2, because in O2 there are 2 oxygen atoms
            physValue COD_ch4= 2 * o2_burn_ch4 * biogas.chemistry.mol_mass_O;

            // g/mol * gCOD/g = gCOD/mol
            COD_ch4= COD_ch4 * new physValue(1, "gCOD/g");

            return COD_ch4;

            // important NEVER throw an error here!
          //default:
            //throw new exception(String.Format("molecule {0} not valid!", molecule));
        }
      }

      physValue ch4;
      
      // mol ch4 per molecule: mol/mol
      buswell_extended(molecule, out ch4);
      
      // gCOD / molecule= mol CH4 / molecule * gCOD / mol CH4
      COD= ch4 * COD_Sch4;

      COD.Symbol= String.Format("COD_{0}", molecule);
      COD.Label=  String.Format("COD in mol {0}", molecule);
      
      return COD;
    }
        
    /// <summary>
    /// Calculates the theoretical oxygen demand (gCOD/g) of the molecule
    /// 
    /// if we only look at c, h, o, then the theoretical oxygen demand is:
    /// 
    /// ( 32 * c + 8 * h - o * 16 ) / ( 12 * c + 1 * h + 16 * o ) 
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>ThOD in gCOD/g of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcTheoreticalOxygenDemand(string molecule)
    {
      physValue ThOD;

      // gCOD/mol / (g/mol) = gCOD/mol * mol/g = gCOD/g
      ThOD= biogas.chemistry.get_COD_of(molecule) / 
            biogas.chemistry.get_mol_mass_of(molecule);

      ThOD.Symbol= String.Format("ThOD_{0}", molecule);
      ThOD.Label=  String.Format("{0} {1}", ThOD.Unit, molecule);

      return ThOD;
    }

    /// <summary>
    /// Calculate total organic carbon (TOC) in g C/g of molecule
    /// the unit is g/g, which results in 100 %. 
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>gTOC/g of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcTOC(string molecule)
    {
      physValue o2, co2;

      // mol/mol of molecule
      combust(molecule, out o2, out co2);

      // g/mol of the molecule
      physValue mol_mass= biogas.chemistry.get_mol_mass_of(molecule);

      // mol/mol * g/mol / (g/mol) = gC / g molecule
      physValue TOC= co2 * mol_mass_C / mol_mass;

      TOC.Symbol = String.Format("TOC_{0}", molecule);
      TOC.Label = String.Format("gTOC/g {0}", molecule);

      return TOC;
    }

    /// <summary>
    /// Calculates the biochemical methane potential in mol ch4 / g of molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>mol ch4 / g of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcBMP(string molecule)
    {
      physValue BMP;

      // ( mol ch4 / mol molecule ) / ( g/mol molecule ) = mol ch4 / g
      BMP= biogas.chemistry.buswell_extended(molecule) / 
           biogas.chemistry.get_mol_mass_of(molecule);

      BMP.Symbol= String.Format("BMP_{0}", molecule);
      BMP.Label= String.Format("{0} {1}", BMP.Unit, molecule);

      return BMP;
    }

    /// <summary>
    /// Calculates the expected CO2 content in the biogas in mol co2 / g of molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>mol co2 / g of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcCO2exp(string molecule)
    {
      physValue CO2_exp, ch4d, co2;

      biogas.chemistry.buswell_extended(molecule, out ch4d, out co2);

      // ( mol co2 / mol molecule ) / ( g/mol molecule ) = mol co2 / g
      CO2_exp = co2 / biogas.chemistry.get_mol_mass_of(molecule);

      CO2_exp.Symbol = String.Format("CO2_exp_{0}", molecule);
      CO2_exp.Label = String.Format("{0} {1}", CO2_exp.Unit, molecule);

      return CO2_exp;
    }

    /// <summary>
    /// Calculates the expected NH3 content in the biogas in mol nh3 / g of molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>mol nh3 / g of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcNH3exp(string molecule)
    {
      physValue NH3_exp, ch4d, co2d, nh3;

      biogas.chemistry.buswell_extended(molecule, out ch4d, out co2d, out nh3);

      // ( mol nh3 / mol molecule ) / ( g/mol molecule ) = mol nh3 / g
      NH3_exp = nh3 / biogas.chemistry.get_mol_mass_of(molecule);

      NH3_exp.Symbol = String.Format("NH3_exp_{0}", molecule);
      NH3_exp.Label = String.Format("{0} {1}", NH3_exp.Unit, molecule);

      return NH3_exp;
    }

    /// <summary>
    /// Calculates the expected H2S content in the biogas in mol h2s / g of molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>mol h2s / g of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcH2Sexp(string molecule)
    {
      physValue H2S_exp, ch4d, co2d, nh3d, h2s;

      biogas.chemistry.buswell_extended(molecule, out ch4d, out co2d, out nh3d, out h2s);

      // ( mol h2s / mol molecule ) / ( g/mol molecule ) = mol h2s / g
      H2S_exp = h2s / biogas.chemistry.get_mol_mass_of(molecule);

      H2S_exp.Symbol = String.Format("H2S_exp_{0}", molecule);
      H2S_exp.Label = String.Format("{0} {1}", H2S_exp.Unit, molecule);

      return H2S_exp;
    }

    /// <summary>
    /// Calculate specific heat (capacity) of given molecule in kJ/(m³ * K). 
    /// Depends on the temperature of the molecule. 
    /// 
    /// s. Ganzheitliche stoffliche und energetische Modellierung S. 76
    /// spez. Wärmekapazität
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="T">temperature of molecule</param>
    /// <returns>specific heat capacity of molecule in kJ/(m³ * K)</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcSpecificHeat(string molecule, physValue T)
    {
      return calcSpecificHeat(molecule, T, true);
    }
    /// <summary>
    /// Calculate specific heat (capacity) of given molecule in kJ/(kg * K). 
    /// Depends on the temperature of the molecule. 
    /// 
    /// s. Ganzheitliche stoffliche und energetische Modellierung S. 76
    /// spez. Wärmekapazität
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="T">temperature of molecule</param>
    /// <param name="per_m3">if true, then return in kJ/(m³ * K) else
    /// in kJ/(kg * K)</param>
    /// <returns>specific heat capacity of molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcSpecificHeat(string molecule, physValue T, bool per_m3)
    {
      physValue c_th= new physValue();

      // convert temperature to °C
      physValue T_C = T.convertUnit("°C");

      switch (molecule)
      { 
        case "H2O":
          c_th = new physValue("c_W", 4.1598 + 4.2091e-4 * T.Value, 
                               "kJ/(kg * K)", "spec. heat water"); break;
        case "Xpr":
          c_th = new physValue("c_pr", 1.6519 + 3.5790e-3 * T.Value,
                               "kJ/(kg * K)", "spec. heat proteins"); break;
        case "Xli":
          c_th = new physValue("c_li", 1.8707 + 2.7594e-3 * T.Value,
                               "kJ/(kg * K)", "spec. heat lipids"); break;
        case "Xch":
          c_th = new physValue("c_ch", 1.8608 + 2.4311e-3 * T.Value,
                               "kJ/(kg * K)", "spec. heat carbohydrates"); break;
        case "Ash":
          c_th = new physValue("c_ash", 0.87567 + 2.0059e-3 * T.Value,
                               "kJ/(kg * K)", "spec. heat ash"); break;
        default:
          throw new exception(String.Format("unknown molecule: {0}!", molecule));
      }

      if (per_m3)
        c_th = c_th * calcDensity(molecule, T);

      return c_th;
    }

    /// <summary>
    /// Calculate raw density of given molecule in kg/m³. 
    /// Depends of the temperature of the molecule. 
    /// 
    /// s. Ganzheitliche stoffliche und energetische Modellierung S. 75
    /// Dichte
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <param name="T">temperature of molecule</param>
    /// <returns>densty of molecule in kg/m^3</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcDensity(string molecule, physValue T)
    {
      physValue rho = new physValue();

      // convert temperature to °C
      physValue T_C = T.convertUnit("°C");

      switch (molecule)
      {
        case "H2O":
          rho = new physValue("rho_W", 1.0104e3 - 4.9437e-1 * T.Value,
                              "kg/m^3", "density water"); break;
        case "Xpr":
          rho = new physValue("rho_pr", 1.3057e3 - 1.1389 * T.Value,
                              "kg/m^3", "density proteins"); break;
        case "Xli":
          rho = new physValue("rho_li", 9.2944e2 - 5.8598e-1 * T.Value,
                              "kg/m^3", "density lipids"); break;
        case "Xch":
          rho = new physValue("rho_ch", 1.4474e3 - 1.2229 * T.Value,
                              "kg/m^3", "density carbohydrates"); break;
        case "Ash":
          rho = new physValue("rho_ash", 1.7662e3 - 1.2039 * T.Value,
                              "kg/m^3", "density ash"); break;
        default:
          throw new exception(String.Format("unknown molecule: {0}!", molecule));
      }

      return rho;
    }

    /// <summary>
    /// calculate expected methane production in m³ / mol molecule
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>expected methane production in m³ / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcCH4vol(string molecule)
    {
      physValue CH4;

      // ( mol ch4 / mol molecule )
      biogas.chemistry.buswell_extended(molecule, out CH4);

      // mol ch4 / mol molecule * g ch4 / mol ch4 * m³/g ch4 = m³ / mol molecule
      CH4 = CH4 * biogas.chemistry.get_mol_mass_of("Sch4") * Vch4.convertUnit("m^3/g");

      return CH4;
    }

    /// <summary>
    /// calculate expected carbon dioxide production in m³ / mol molecule
    /// 
    /// TODO: nutzung von combusion eq. sollte eigentlich schneller sein???
    /// nein, da hier erwartete CO2 produktion aus anaerobe Fermentation berechnet wird
    /// und nicht durch Verbrennung
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>expected carbon dioxide production in m³ / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcCO2vol(string molecule)
    {
      physValue CH4, CO2;

      // ( mol ch4 / mol molecule )
      // ( mol co2 / mol molecule )
      biogas.chemistry.buswell_extended(molecule, out CH4, out CO2);

      // g co2 / mol molecule * m³/g = m³ / mol molecule
      CO2= CO2 * biogas.chemistry.get_mol_mass_of("Sco2") * Vco2.convertUnit("m^3/g");

      return CO2;
    }

    /// <summary>
    /// calculate expected ammonia production in m³ / mol molecule
    /// 
    /// TODO: nutzung von combusion eq. sollte eigentlich schneller sein???
    /// nein, da hier erwartete NH3 produktion aus anaerobe Fermentation berechnet wird
    /// und nicht durch Verbrennung
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>expected ammonia production in m³ / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcNH3vol(string molecule)
    {
      physValue CH4, CO2, NH3;

      // ( mol ch4 / mol molecule )
      // ( mol co2 / mol molecule )
      // ( mol nh3 / mol molecule )
      biogas.chemistry.buswell_extended(molecule, out CH4, out CO2, out NH3);

      // g nh3 / mol molecule * m³/g = m³ / mol molecule
      NH3 = NH3 * biogas.chemistry.get_mol_mass_of("Snh3") * Vnh3.convertUnit("m^3/g");

      return NH3;
    }

    /// <summary>
    /// calculate expected hydrogen sulfide production in m³ / mol molecule
    /// 
    /// TODO: nutzung von combusion eq. sollte eigentlich schneller sein???
    /// nein, da hier erwartete H2S produktion aus anaerobe Fermentation berechnet wird
    /// und nicht durch Verbrennung
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>expected hydrogen sulfide production in m³ / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcH2Svol(string molecule)
    {
      physValue CH4, CO2, NH3, H2S;

      // ( mol ch4 / mol molecule )
      // ( mol co2 / mol molecule )
      // ( mol nh3 / mol molecule )
      // ( mol h2s / mol molecule )
      biogas.chemistry.buswell_extended(molecule, out CH4, out CO2, out NH3, out H2S);

      // g h2s / mol molecule * m³/g = m³ / mol molecule
      H2S = H2S * biogas.chemistry.get_mol_mass_of("Sh2s") * Vh2s.convertUnit("m^3/g");

      return H2S;
    }

    /// <summary>
    /// Calculates gas quality of molecule.
    /// gas quality: % methane content in resulting biogas
    /// based on ratio of ch4 to ch4 + co2 + nh3 + h2s
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>ch4 content in biogas</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    /// <exception cref="exception">Division by zero</exception>
    public static physValue calcGasQuality(string molecule)
    {
      physValue gasQuality;

      // m³ ch4 / mol molecule
      physValue CH4= calcCH4vol(molecule);
      // m³ co2 / mol molecule
      physValue biogas= calcBiogasvol(molecule);
      
      gasQuality= CH4 / biogas;
      gasQuality= gasQuality.convertUnit("%");

      gasQuality.Symbol= String.Format("gasQuality(ch4)_{0}", molecule);
      gasQuality.Label= "gas quality: ch4 content";

      return gasQuality;
    }

    /// <summary>
    /// Calculate biogas amount of given molecule in m³ / mol molecule.
    /// biogas is sum of ch4, co2, nh3, h2s
    /// </summary>
    /// <param name="molecule">molecule</param>
    /// <returns>m^3 biogas / molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue calcBiogasvol(string molecule)
    {
      physValue biogas;

      // m³ ch4 / mol molecule
      physValue CH4 = calcCH4vol(molecule);
      // m³ co2 / mol molecule
      physValue CO2 = calcCO2vol(molecule);
      // m³ nh3 / mol molecule
      physValue NH3 = calcNH3vol(molecule);
      // m³ h2s / mol molecule
      physValue H2S = calcH2Svol(molecule);

      biogas = CH4 + CO2 + NH3 + H2S;

      biogas.Symbol = String.Format("biogas_{0}", molecule);
      biogas.Label = "biogas";

      return biogas;
    }



  }
}


