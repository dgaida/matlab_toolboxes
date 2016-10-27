/**
 * This file is part of the partial class chemistry and contains
 * the get_..._of methods (... are C, H, O, N, S).
 * 
 * TODOs:
 * 
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
    /// Returns C content of molecule. mol C / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="C">mol C / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_C_of(string molecule, out physValue C)
    {
      physValue H;

      get_CH_of(molecule, out C, out H);
    }
    /// <summary>
    /// Returns C content of molecule. mol C / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <returns>mol C / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_C_of(string molecule)
    {
      physValue C, H;

      get_CH_of(molecule, out C, out H);

      return C;
    }
    /// <summary>
    /// Returns H content of molecule. mol H / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="H">mol H / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_H_of(string molecule, out physValue H)
    {
      physValue C;

      get_CH_of(molecule, out C, out H);
    }
    /// <summary>
    /// Returns H content of molecule. mol H / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <returns>mol H / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_H_of(string molecule)
    {
      physValue C, H;

      get_CH_of(molecule, out C, out H);

      return H;
    }
    /// <summary>
    /// Returns O content of molecule. mol O / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="O">mol O / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_O_of(string molecule, out physValue O)
    {
      physValue H;
      physValue C;

      get_CHO_of(molecule, out C, out H, out O);
    }
    /// <summary>
    /// Returns O content of molecule. mol O / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <returns>mol O / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_O_of(string molecule)
    {
      physValue C, H, O;

      get_CHO_of(molecule, out C, out H, out O);

      return O;
    }
    /// <summary>
    /// Returns N content of molecule. mol N / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="N">mol N / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_N_of(string molecule, out physValue N)
    {
      physValue C;
      physValue H;
      physValue O;

      get_CHON_of(molecule, out C, out H, out O, out N);
    }
    /// <summary>
    /// Returns N content of molecule. mol N / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <returns>mol N / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_N_of(string molecule)
    {
      physValue C, H, O, N;

      get_CHON_of(molecule, out C, out H, out O, out N);

      return N;
    }
    /// <summary>
    /// Returns S content of molecule. mol S / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="S">mol S / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_S_of(string molecule, out physValue S)
    {
      physValue C;
      physValue H;
      physValue O;
      physValue N;

      get_CHONS_of(molecule, out C, out H, out O, out N, out S);
    }
    /// <summary>
    /// Returns S content of molecule. mol S / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <returns>mol S / mol molecule</returns>
    /// <exception cref="exception">Unknown molecule</exception>
    public static physValue get_S_of(string molecule)
    {
      physValue C, H, O, N, S;

      get_CHONS_of(molecule, out C, out H, out O, out N, out S);

      return S;
    }
    /// <summary>
    /// Returns C and H content of molecule. mol C, H / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="C">mol C / mol molecule</param>
    /// <param name="H">mol H / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_CH_of(string molecule, out physValue C, out physValue H)
    {
      physValue O;

      get_CHO_of(molecule, out C, out H, out O);
    }
    /// <summary>
    /// Returns C, H and O content of molecule. mol / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="C">mol C / mol molecule</param>
    /// <param name="H">mol H / mol molecule</param>
    /// <param name="O">mol O / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_CHO_of(string molecule, out physValue C, out physValue H, 
                                                     out physValue O)
    {
      physValue N;

      get_CHON_of(molecule, out C, out H, out O, out N);
    }
    /// <summary>
    /// Returns C, H, O and N content of molecule. mol / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="C">mol C / mol molecule</param>
    /// <param name="H">mol H / mol molecule</param>
    /// <param name="O">mol O / mol molecule</param>
    /// <param name="N">mol N / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_CHON_of(string molecule, out physValue C, out physValue H, 
                                                     out physValue O, out physValue N)
    {
      physValue S;

      get_CHONS_of(molecule, out C, out H, out O, out N, out S);
    }
    /// <summary>
    /// Returns C, H, O, N and S content of molecule. mol / molecule
    /// </summary>
    /// <param name="molecule">string of molecule</param>
    /// <param name="C">mol C / mol molecule</param>
    /// <param name="H">mol H / mol molecule</param>
    /// <param name="O">mol O / mol molecule</param>
    /// <param name="N">mol N / mol molecule</param>
    /// <param name="S">mol S / mol molecule</param>
    /// <exception cref="exception">Unknown molecule</exception>
    public static void get_CHONS_of(string molecule, out physValue C, out physValue H, 
                                                     out physValue O, 
                                                     out physValue N, out physValue S)
    { 
      // set values to default, then in each "switch case" only the components != 0
      // have to be set
      double c= 0;       // number of mol carbon in mol of molecule
      double h= 0;       // number of mol hydrogen in mol of molecule
      double o= 0;       // number of mol oxygen in mol of molecule
      double n= 0;       // number of mol nitrogen in mol of molecule
      double s= 0;       // number of mol sulphur in mol of molecule

      //

      switch (molecule)
      {
        // reinen Moleküle
        case "C":
          c = 1; break;
        case "H":
          h = 1; break;
        case "O":
          o = 1; break;
        case "N":
          n = 1; break;
        case "S":
          s = 1; break;
          
        // acids

        case "Sac_":  // conjugate base of the acetic acid: 
                      // acetate: CH_3COO- + H^+
        case "Shac":  // acetic acid: CH_3COOH
        case "Sac":   // sum parameter of acetate and acetic acid
          c= 2;   h= 4;   o= 2; break;

        case "Spro_": // conjugate base of the propionic acid: 
                      // propionate: C_2H_5COO- + H^+
        case "Shpro": // propionic acid: C_2H_5COOH
        case "Spro":  // sum parameter of propionate and propionic acid
          c= 3;   h= 6;   o= 2; break;

        case "Sbu_":  // conjugate base of the butanoic (butyric) acid: 
                      // butyrate: C_3H_7COO- + H^+
        case "Shbu":  // butanoic (butyric) acid: C_3H_7COOH
        case "Sbu":   // sum parameter of butyrate and butyric acid
          c= 4;   h= 8;   o= 2; break;

        case "Sva_":  // conjugate base of the valeric acid: 
                      // valerate: C_4H_9COO- + H^+  
        case "Shva":  // valeric acid: C_4H_9COOH
        case "Sva":   // sum parameter of valerate and valeric acid
          c= 5;   h= 10;  o= 2; break;

        
        // gases

        case "Sch4":  // methane: CH_4
          c= 1;
          h= 4; break;

        case "Sco2":  // carbon dioxide: CO_2
          c= 1;
          o= 2; break;

        case "So2":   // oxygen: O_2
          o= 2; break;
          
        case "Sh2":   // hydrogen: H_2
          h= 2; break;
         
        case "Sh2s":  // hydrogen sulphide: H_2S
          h= 2;
          s= 1; break;

        //

        case "Shco3":  // HCO_3
          h= 1;
          c= 1;
          o= 3; break;

        //
        
        case "Snh3":  // ammonia: NH_3
          n= 1;
          h= 3; break;
         
        case "Snh4":  // ammonium: NH_4
          n= 1;
          h= 4; break;
        
        
        // 

        // source:
        // Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und
        // Regelung - 
        case "Saa":   // mean of 20 proteinogen amino acid
          // Alanin, Arginin, Asparagin, Asparaginsäure, Cystein, Glutamin, Glutamsäure, 
          // Glycin, Histidin, Isoleucin, Leucin, Lysin, Methionin, Phenylalanin, 
          // Prolin, Serin, Threonin, Tryptophan, Tryosin, Valin
          //
          double[] c_array= {3,  6, 4, 4, 3,  5, 5, 2, 6,  6,  6,  6,  5,  9, 5, 3, 4, 11,  9,  5};
          double[] h_array= {7, 14, 8, 7, 7, 10, 9, 5, 9, 13, 13, 14, 11, 11, 9, 7, 9, 12, 11, 11};
          double[] o_array= {2,  2, 3, 4, 2,  3, 4, 2, 2,  2,  2,  2,  2,  2, 2, 3, 3,  2,  3,  2};
          double[] n_array= {1,  4, 2, 1, 1,  2, 1, 1, 3,  1,  1,  2,  1,  1, 1, 1, 1,  2,  1,  1};
          
          c= math.mean(c_array);
          h= math.mean(h_array);
          o= math.mean(o_array);
          n= math.mean(n_array);
          s= (1 + 1) / 20; break;

        //
        case "Sfa":   // mean of three long chain fatty acids
          // palmitic acid: C_15H_31COOH 
          // oil acid: C_17H_33COOH 
          // stearic acid: C_17H_35COOH 
          double[] c_array2= {16, 18, 18};
          double[] h_array2= {32, 34, 36};
          double[] o_array2= { 2,  2,  2};

          c= math.mean(c_array2);
          h= math.mean(h_array2);
          o= math.mean(o_array2); break;
          
        // source:
        // Die anaerobe Fermentation - Theoretische Grundlagen, Simulation und
        // Regelung - 
        case "Ssu":   // monosaccharide: C_6H_12O_6
          c= 6;
          h= 12;
          o= 6; break;

        
        // particulates

        // source:
        // Biogas from grass silage - Measurements and modeling with ADM1
        case "Xch":   // carbohydrates: C_6H_10O_5
          c= 6;
          h= 10;
          o= 5; break;

        // source:
        // Biogas from grass silage - Measurements and modeling with ADM1
        case "Xpr":   // proteins: C_5H_7O_2N
          c= 5;
          h= 7;
          o= 2;
          n= 1; break;

        // source:
        // Biogas from grass silage - Measurements and modeling with ADM1
        case "Xli":   // lipids: C_57H_104O_6
          c= 57;
          h= 104;
          o= 6; break;
          
        // source:
        // Biogas from grass silage - Measurements and modeling with ADM1
        case "Lignin":  // lignin: C_10.92H_14.24O_5.76
          c= 10.92;
          h= 14.24;
          o= 5.76; break;

        // source:
        // ADM1 report: because Xbio has a COD of 160 gCOD/mol and a molar mass of
        // 113 g/mol, same as proteins
        case "Xbio":
        case "Xsu":
        case "Xaa": 
        case "Xfa":
        case "Xc4":
        case "Xpro": 
        case "Xac":
        case "Xh2":   // biomass: C_5H_7O_2N
          c= 5;
          h= 7;
          o= 2;
          n= 1; break;
          
        default:

          throw new exception( String.Format("Unknown molecule: {0}!", molecule) );

    }

          
    //

    C= new physValue("c", c, "mol/mol",
                     String.Format("mol carbon in mol {0}", molecule));
    H= new physValue("h", h, "mol/mol", 
                     String.Format("mol hydrogen in mol {0}", molecule));
    O= new physValue("o", o, "mol/mol",
                     String.Format("mol oxygen in mol {0}", molecule));
    N= new physValue("n", n, "mol/mol",
                     String.Format("mol nitrogen in mol {0}", molecule));
    S= new physValue("s", s, "mol/mol",
                     String.Format("mol sulphur in mol {0}", molecule));

    //

    }



  }
}


