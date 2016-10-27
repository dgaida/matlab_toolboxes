/**
 * This file defines the class ADMparams.
 * 
 * TODOs:
 * - At the moment only defines positions of ADM params in the params vector. 
 * - what should it be used for?
 * 
 * 
 * Hinweis: Da es momentan nicht möglich ist, ADM und ADMparams abzuleiten
 * da zu viel mit statischen methoden gearbeitet wird, sollte diese
 * klasse möglichst wenige public parameter definieren um bei einem
 * wechsel des adm modells alles möglichst kompakt in den zwei klassen
 * adm und admparams (admstate) zu haben. 
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;

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
  /// 
  /// TODO:
  /// Define what this class should be used for
  /// 
  /// </summary>
  public partial class ADMparams
  {
    // TODO
    // alle pos variablen sollten private oder zumindest protected sein
    // da sie sonst überall genutzt werden können, macht
    // ein ADM modell wechsel unmöglich
    // falls private/protected nicht funktioniert, sollte zumindest
    // das schlüsselwort inernal anstatt public genutzt werden.
    // s. http://msdn.microsoft.com/de-de/library/7c5ka91b%28v=vs.80%29.aspx
    //
    // wird von matlab funktion
    // init_ADMparams_from_mat_file
    // genutzt

    /// <summary>
    /// 
    /// </summary>
    public static int pos_fSI_XC= 1;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_fXI_XC= 2;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_fCH_XC= 3;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_fPR_XC= 4;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_fLI_XC= 5;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_fXP_XC= 6;

    /// <summary>
    /// das war ehemals die Position von N_Xc
    /// N_Xc wird jetzt berechnet aus fSIN_Xc und weiteren
    /// fSIN_Xc wird über NH4+NH3 fraction of XC bestimmt
    /// </summary>
    public static int pos_fSIN_XC = 7;


    /// <summary>
    /// 
    /// </summary>
    public static int pos_kdis= 48;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_khyd_ch= 49;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_khyd_pr= 50;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_khyd_li= 51;

    /// <summary>
    /// 
    /// </summary>
    public static int pos_km_c4 = 62;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KS_c4 = 63;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KI_H2_c4 = 64;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_km_pro = 65;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KS_pro = 66;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KI_H2_pro = 67;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_km_ac = 68;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KS_ac = 69;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KI_NH3 = 70;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_pHUL_ac = 71;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_pHLL_ac = 72;

    /// <summary>
    /// 
    /// </summary>
    public static int pos_km_h2 = 73;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_KS_h2 = 74;

    /// <summary>
    /// 
    /// </summary>
    public static int pos_kdec_Xsu = 77;
    
    /// <summary>
    /// 
    /// </summary>
    public static int pos_kdec_Xac = 82;
    /// <summary>
    /// 
    /// </summary>
    public static int pos_kdec_Xh2 = 83;



    /// <summary>
    /// number of params in the ADM1 model
    /// darf public sein
    /// </summary>
    public static int numParams= 105;

    //

    

  }
}


