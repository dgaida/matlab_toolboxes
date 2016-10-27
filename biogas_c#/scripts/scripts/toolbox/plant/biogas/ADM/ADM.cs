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
* This file defines the partial class ADM.
* 
* TODOs:
* - maybe add further methods, not yet clear how this class should be used
* - only defines ADM params and sets them depending on the substrate feed
* - s. TODO in getParams
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
using toolbox;
using science;

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
  /// Class defining the Anaerobic Digestion Model
  /// 
  /// At the moment is defines two things:
  /// - the ADM parameters
  /// - handle of the MATLAB gui for the ADM block
  /// 
  /// TODO:
  /// Using the child class ADM1DE different ADM models should
  /// be implementable, but this won't work, because in ADMstate
  /// static properties such as dim_state, dim_stream are defined,
  /// which cannot be overwritten. We need the static props in MATLAB.
  /// 
  /// </summary>
  public partial class ADM
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Standard Constructor sets default values of ADM parameters
    /// </summary>
    /// <param name="T">digester temperature in °C</param>
    public ADM(physValue T)
    {
      T = T.convertUnit("°C");

      // set default parameter values
      setDefaultParams(T.Value);
    }



    // -------------------------------------------------------------------------------------
    //                              !!! GET METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns default values of ADM params vector, not dependent on substrate feed
    /// 
    /// if getParams method was called before (see below], then
    /// this method returns the last updated ADM params
    /// </summary>
    /// <returns></returns>
    public double[] getDefaultParams()
    {
      return _parameters;
    }

    /// <summary>
    /// Get all ADM parameters as single variables
    /// </summary>
    /// <param name="fSI_XC"></param>
    /// <param name="fXI_XC"></param>
    /// <param name="fCH_XC"></param>
    /// <param name="fPR_XC"></param>
    /// <param name="fLI_XC"></param>
    /// <param name="fXP_XC"></param>
    /// <param name="N_Xc">TODO - an der Stelle steht jetzt fSIN_Xc</param>
    /// <param name="N_I"></param>
    /// <param name="N_aa"></param>
    /// <param name="C_Xc"></param>
    /// <param name="C_SI"></param>
    /// <param name="C_Xch"></param>
    /// <param name="C_Xpr"></param>
    /// <param name="C_Xli"></param>
    /// <param name="C_XI"></param>
    /// <param name="fFA_Xli"></param>
    /// <param name="C_Sfa"></param>
    /// <param name="fH2_SU"></param>
    /// <param name="fBU_SU"></param>
    /// <param name="fPRO_SU"></param>
    /// <param name="N_XB"></param>
    /// <param name="C_Sbu"></param>
    /// <param name="C_Spro"></param>
    /// <param name="C_Sac"></param>
    /// <param name="C_XB"></param>
    /// <param name="Ysu"></param>
    /// <param name="fH2_AA"></param>
    /// <param name="fVA_AA"></param>
    /// <param name="fBU_AA"></param>
    /// <param name="fPRO_AA"></param>
    /// <param name="C_Sva"></param>
    /// <param name="Yaa"></param>
    /// <param name="fH2_FA"></param>
    /// <param name="Yfa"></param>
    /// <param name="fH2_VA"></param>
    /// <param name="fPRO_VA"></param>
    /// <param name="fH2_BU"></param>
    /// <param name="Yc4"></param>
    /// <param name="fH2_PRO"></param>
    /// <param name="Ypro"></param>
    /// <param name="C_Sch4"></param>
    /// <param name="Yac"></param>
    /// <param name="Yh2"></param>
    /// <param name="kdis"></param>
    /// <param name="khyd_ch"></param>
    /// <param name="khyd_pr"></param>
    /// <param name="khyd_li"></param>
    /// <param name="KS_IN"></param>
    /// <param name="km_su"></param>
    /// <param name="KS_su"></param>
    /// <param name="pHUL_a"></param>
    /// <param name="pHLL_a"></param>
    /// <param name="km_aa"></param>
    /// <param name="KS_aa"></param>
    /// <param name="km_fa"></param>
    /// <param name="KS_fa"></param>
    /// <param name="KI_H2_fa"></param>
    /// <param name="km_c4"></param>
    /// <param name="KS_c4"></param>
    /// <param name="KI_H2_c4"></param>
    /// <param name="km_pro"></param>
    /// <param name="KS_pro"></param>
    /// <param name="KI_H2_pro"></param>
    /// <param name="km_ac"></param>
    /// <param name="KS_ac"></param>
    /// <param name="KI_NH3"></param>
    /// <param name="pHUL_ac"></param>
    /// <param name="pHLL_ac"></param>
    /// <param name="km_h2"></param>
    /// <param name="KS_h2"></param>
    /// <param name="pHUL_h2"></param>
    /// <param name="pHLL_h2"></param>
    /// <param name="kdec_Xsu"></param>
    /// <param name="kdec_Xaa"></param>
    /// <param name="kdec_Xfa"></param>
    /// <param name="kdec_Xc4"></param>
    /// <param name="kdec_Xpro"></param>
    /// <param name="kdec_Xac"></param>
    /// <param name="kdec_Xh2"></param>
    /// <param name="Kw"></param>
    /// <param name="Kava"></param>
    /// <param name="Kabu"></param>
    /// <param name="Kapro"></param>
    /// <param name="Kaac"></param>
    /// <param name="Kaco2"></param>
    /// <param name="Kain"></param>
    /// <param name="kA_Bva"></param>
    /// <param name="kA_Bbu"></param>
    /// <param name="kA_Bpro"></param>
    /// <param name="kA_Bac"></param>
    /// <param name="kA_Bco2"></param>
    /// <param name="kA_Bin"></param>
    /// <param name="klaH2"></param>
    /// <param name="klaCH4"></param>
    /// <param name="klaCO2"></param>
    /// <param name="KH_CO2"></param>
    /// <param name="KH_CH4"></param>
    /// <param name="KH_H2"></param>
    /// <param name="C_Xp"></param>
    /// <param name="N_Xp"></param>
    /// <param name="fP"></param>
    public void getADMparameters(out double fSI_XC, out double fXI_XC, out double fCH_XC, 
      out double fPR_XC, out double fLI_XC, out double fXP_XC, out double N_Xc, 
      out double N_I, out double N_aa, out double C_Xc, out double C_SI, 
      out double C_Xch, out double C_Xpr, out double C_Xli, out double C_XI, 
      out double fFA_Xli, out double C_Sfa, out double fH2_SU, out double fBU_SU, 
      out double fPRO_SU, out double N_XB, out double C_Sbu, out double C_Spro, 
      out double C_Sac, out double C_XB, out double Ysu, out double fH2_AA, 
      out double fVA_AA, out double fBU_AA, out double fPRO_AA, out double C_Sva, 
      out double Yaa, out double fH2_FA, out double Yfa, out double fH2_VA, 
      out double fPRO_VA, out double fH2_BU, out double Yc4, out double fH2_PRO, 
      out double Ypro, out double C_Sch4, out double Yac, out double Yh2, 
      out double kdis, out double khyd_ch, out double khyd_pr, out double khyd_li, 
      out double KS_IN, out double km_su, out double KS_su, out double pHUL_a, 
      out double pHLL_a, out double km_aa, out double KS_aa, out double km_fa, 
      out double KS_fa, out double KI_H2_fa, out double km_c4, out double KS_c4, 
      out double KI_H2_c4, out double km_pro, out double KS_pro, out double KI_H2_pro, 
      out double km_ac, out double KS_ac, out double KI_NH3, out double pHUL_ac, 
      out double pHLL_ac, out double km_h2, out double KS_h2, out double pHUL_h2, 
      out double pHLL_h2, out double kdec_Xsu, out double kdec_Xaa, out double kdec_Xfa, 
      out double kdec_Xc4, out double kdec_Xpro, out double kdec_Xac, out double kdec_Xh2, 
      out double Kw, out double Kava, out double Kabu, out double Kapro, out double Kaac, 
      out double Kaco2, out double Kain, out double kA_Bva, out double kA_Bbu, 
      out double kA_Bpro, out double kA_Bac, out double kA_Bco2, out double kA_Bin, 
      out double klaH2, out double klaCH4, out double klaCO2, out double KH_CO2,
      out double KH_CH4, out double KH_H2, out double C_Xp, out double N_Xp, out double fP)
    {
      // TODO warum werden positionen in ADMparams definiert
      // wenn sie hier nicht genutzt werden?
      fSI_XC= _parameters[0];             	// fraction SI from XC
      fXI_XC = _parameters[1];
      fCH_XC= _parameters[2];              // fraction Xch from XC
      fPR_XC= _parameters[3];              // fraction Xpr from XC
      fLI_XC= _parameters[4];              // fraction Xli from XC
      fXP_XC= _parameters[5];              // fraction Xp from XC
      // TODO - an der Stelle steht jetzt fSIN_Xc
      N_Xc= _parameters[6];
      N_I= _parameters[7];
      N_aa= _parameters[8];
      C_Xc= _parameters[9];
      C_SI= _parameters[10];
      C_Xch= _parameters[11];
      C_Xpr= _parameters[12];
      C_Xli= _parameters[13];
      C_XI= _parameters[14];


      fFA_Xli= _parameters[17];
      C_Sfa= _parameters[18];
      fH2_SU= _parameters[19];
      fBU_SU= _parameters[20];
      fPRO_SU= _parameters[21];

      N_XB= _parameters[23];
      C_Sbu= _parameters[24];
      C_Spro= _parameters[25];
      C_Sac= _parameters[26];
      C_XB= _parameters[27];
      Ysu= _parameters[28];
      fH2_AA= _parameters[29];
      fVA_AA= _parameters[30];
      fBU_AA= _parameters[31];
      fPRO_AA= _parameters[32];

      C_Sva= _parameters[34];
      Yaa= _parameters[35];
      fH2_FA= _parameters[36];
      Yfa= _parameters[37];
      fH2_VA= _parameters[38];
      fPRO_VA= _parameters[39];
      fH2_BU= _parameters[40];
      Yc4= _parameters[41];
      fH2_PRO= _parameters[42];
      Ypro= _parameters[43];
      C_Sch4= _parameters[44];
      Yac= _parameters[45];
      Yh2= _parameters[46];
      kdis= _parameters[47];
      khyd_ch= _parameters[48];
      khyd_pr= _parameters[49];
      khyd_li= _parameters[50];
      KS_IN= _parameters[51];
      km_su= _parameters[52];
      KS_su= _parameters[53];
      pHUL_a= _parameters[54];
      pHLL_a= _parameters[55];
      km_aa= _parameters[56];
      KS_aa= _parameters[57];
      km_fa= _parameters[58];
      KS_fa= _parameters[59];
      KI_H2_fa= _parameters[60];
      km_c4= _parameters[61];
      KS_c4= _parameters[62];
      KI_H2_c4= _parameters[63];
      km_pro= _parameters[64];
      KS_pro= _parameters[65];
      KI_H2_pro= _parameters[66];
      km_ac= _parameters[67];
      KS_ac= _parameters[68];
      KI_NH3= _parameters[69];
      pHUL_ac= _parameters[70];
      pHLL_ac= _parameters[71];
      km_h2= _parameters[72];
      KS_h2= _parameters[73];
      pHUL_h2= _parameters[74];
      pHLL_h2= _parameters[75];
      kdec_Xsu= _parameters[76];
      kdec_Xaa= _parameters[77];
      kdec_Xfa= _parameters[78];
      kdec_Xc4= _parameters[79];
      kdec_Xpro= _parameters[80];
      kdec_Xac= _parameters[81];
      kdec_Xh2= _parameters[82];
      Kw= _parameters[83];
      Kava= _parameters[84];
      Kabu= _parameters[85];
      Kapro= _parameters[86];
      Kaac= _parameters[87];
      Kaco2= _parameters[88];
      Kain= _parameters[89];
      kA_Bva= _parameters[90];
      kA_Bbu= _parameters[91];
      kA_Bpro= _parameters[92];
      kA_Bac= _parameters[93];
      kA_Bco2= _parameters[94];
      kA_Bin= _parameters[95];
      klaH2= _parameters[96];
      klaCH4= _parameters[97];
      klaCO2= _parameters[98];
      KH_CO2= _parameters[99];
      KH_CH4= _parameters[100];
      KH_H2= _parameters[101];
      C_Xp= _parameters[102];
      N_Xp= _parameters[103];
      fP= _parameters[104];
    }

    /// <summary>
    /// Returns the ADM params vector, depending on the current substrate feed.
    /// The current substrate feed is taken out of the current substrate feed 
    /// measurement in mySensors
    /// 
    /// Attention!!! Changes the values of the ADM params!!!
    /// 
    /// the following params depend on the substrate feed:
    /// - XC fractions (fCH_XC, fLI_XC, ...]
    /// - disintegration constant: kdis
    /// - hydrolysis constant: khyd_ch, khyd_pr, khyd_li
    /// </summary>
    /// <param name="t">current simulation time measured in days</param>
    /// <param name="mySensors"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network_digester"></param>
    /// <param name="digesterID">digester id</param>
    /// <returns></returns>
    public double[] getParams(double t, sensors mySensors, substrates mySubstrates,
                              double[] substrate_network_digester, String digesterID/*, 
                              double deltatime*/)
    {
      double[] Q;
      
      mySensors.getMeasurementsAt("Q", "Q", t, mySubstrates, out Q);

      // multiply the two vectors with the vector product
      // two column vector are multiplied therefore a column vector is returned
      Q = math.times(substrate_network_digester, Q);

      double QdigesterIn;

      mySensors.getCurrentMeasurementD(String.Format("Q_{0}_2", digesterID), out QdigesterIn);

      double[] ADMparams = getParams(t, Q, QdigesterIn, mySubstrates); // , mySensors.isEmpty()

      // measurement of ADM1 params to sensors
      mySensors.measure(t, "ADMparams_" + digesterID, ADMparams);

      return ADMparams;
    }

    /// <summary>
    /// Returns the ADM params vector, but the substrate dependent parameters
    /// are returned as normal means, not weighted means
    /// </summary>
    /// <param name="mySubstrates"></param>
    /// <returns></returns>
    public double[] getParams(substrates mySubstrates)
    {
      double[] Q= new double[mySubstrates.getNumSubstrates()];

      for (int isubstrate = 0; isubstrate < mySubstrates.getNumSubstrates(); isubstrate++)
        Q[isubstrate] = 1;

      return getParams(0, Q, math.sum(Q), mySubstrates); // , true
    }

    /// <summary>
    /// Returns the ADM params vector, depending on the current substrate feed
    /// 
    /// Attention!!! Changes the values of the ADM params!!!
    /// 
    /// the following params depend on the substrate feed:
    /// - XC fractions (fCH_XC, fLI_XC, ...]
    /// - disintegration constant: kdis
    /// - hydrolysis constant: khyd_ch, khyd_pr, khyd_li
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="Q">substrate feed measured in m^3/d</param>
    /// <param name="QdigesterIn">total volumetric flow rate in digester in m^3/d</param>
    /// <param name="mySubstrates"></param>
    /// <returns></returns>
    public double[] getParams(double t, double[] Q, double QdigesterIn, substrates mySubstrates)
    {
      double fCH_XC, fLI_XC, fPR_XC,
             fSI_XC, fXI_XC, fXP_XC;

      // TODO
      // das Problem wenn fermenter nicht gefüttert wird, also Q am Anfang nur 0er hat, dann
      // werden alle Substrate in berechnung einbezogen der Parameter
      // fFactors, km_...
      // und nicht nur die Substrate, welche zu dem zeitpunkt gefüttert werden.
      // kdis und khyd haben nicht das problem, da sie mit gewichtet werden, eine
      // nicht gefütterte anlage arbeitet dann mit defualt werten s.u.

      // es gibt das problem, dass wenn man simulation in stücke teilt, dass dann adm1 parameter
      // am ende der simulation in mat datei gespeichert werden müssen. da hier nur am "start"
      // der simulation, d.h. bei t= 0, die parameter frei gesetzt werden, sonst werden die nur
      // verändert wenn unten angegebene bedingungen erfüllt sind wie in einer normalen simulation
      // wenn das speichern von parametern gewünscht ist, muss in matlab die save_ADMparams_to_mat_file
      // aufgerufen werden nach der simulation
      // true if we are at start of simulation else false
      bool start_of_simulation = (t == 0);

      // get current XC fractions
      mySubstrates.calcfFactors(Q, out fCH_XC, out fPR_XC, out fLI_XC,
                                   out fXI_XC, out fSI_XC, out fXP_XC);

      //

      double fSIN_XC = mySubstrates.calcfSIN_Xc(Q);

      //

      double kdis= mySubstrates.calcDisintegrationParam(Q);

      double khyd_ch, khyd_pr, khyd_li;

      mySubstrates.calcHydrolysisParams(Q, out khyd_ch, out khyd_pr, out khyd_li);


      double km_c4, km_pro, km_ac, km_h2;

      mySubstrates.calcMaxUptakeRateParams(Q, out km_c4, out km_pro, out km_ac, out km_h2);

      double f_ub = 0.2;

      // set params in params vector
      if (math.sum(Q) > 0 || QdigesterIn > 0 || start_of_simulation)    
        // TODO: das bedeutet, dass nur gefütterter Fermenter gesetzt wird
        // ist das gewollt? mit dem || bedeutet, dass Fermenter gefüttert werden muss
        // egal ob mit substrat oder schlamm
      {
        // TODO: es darf hier nicht passieren, dass ein paar Parameter gesetzt werden
        // und andere nicht, da sonst die Summe == 1 nicht mehr stimmt

        // else do not set these parameters, use standard parameters instead
        if (fSI_XC >= 0 && (Math.Abs(_parameters[ADMparams.pos_fSI_XC - 1] - fSI_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fSI_XC - 1]= fSI_XC;

        // TODO - es bringt eigentlich nichts diesen wert hier zu setzen, da er in ADM1
        // stoichiometry aus anderern Parametern berechnet wird
        if (fXI_XC >= 0 && (Math.Abs(_parameters[ADMparams.pos_fXI_XC - 1] - fXI_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fXI_XC - 1] = fXI_XC;

        if (fCH_XC >= 0 && (Math.Abs(_parameters[ADMparams.pos_fCH_XC - 1] - fCH_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fCH_XC - 1]= fCH_XC;

        if (fPR_XC >= 0 && (Math.Abs(_parameters[ADMparams.pos_fPR_XC - 1] - fPR_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fPR_XC - 1]= fPR_XC;

        if (fLI_XC >= 0 && (Math.Abs(_parameters[ADMparams.pos_fLI_XC - 1] - fLI_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fLI_XC - 1] = fLI_XC;

        // TODO: fXP_XC kann auch ganz leicht negativ werden, da er durch substraktion
        // der anderen Parameter von 1 entsteht
        if (/*fXP_XC >= 0 && */(Math.Abs(_parameters[ADMparams.pos_fXP_XC - 1] - fXP_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fXP_XC - 1] = Math.Max(fXP_XC, 0.0);


        if (fSIN_XC >= 0 && (Math.Abs(_parameters[ADMparams.pos_fSIN_XC - 1] - fSIN_XC) < f_ub || start_of_simulation))
          _parameters[ADMparams.pos_fSIN_XC - 1] = fSIN_XC;


        if (km_c4 >= 0 && (Math.Abs(_parameters[ADMparams.pos_km_c4 - 1] - km_c4) < 5 || start_of_simulation ) )
          _parameters[ADMparams.pos_km_c4 - 1] = km_c4;
        if (km_pro >= 0 && (Math.Abs(_parameters[ADMparams.pos_km_pro - 1] - km_pro) < 5 || start_of_simulation ) )
          _parameters[ADMparams.pos_km_pro - 1] = km_pro;
        if (km_ac >= 0 && (Math.Abs(_parameters[ADMparams.pos_km_ac - 1] - km_ac) < 5 || start_of_simulation ) )
          _parameters[ADMparams.pos_km_ac - 1] = km_ac;
        if (km_h2 >= 0 && (Math.Abs(_parameters[ADMparams.pos_km_h2 - 1] - km_h2) < 5 || start_of_simulation))
          _parameters[ADMparams.pos_km_h2 - 1] = km_h2;

      }

      // TODO
      // was besseres überlegen
      // 150000 stehen für Schlamm, welcher schon abgebaut wurde
      // kdis hat im Nachgärer kaum Auswirkungen, Xc scheint schon sehr stark abgebaut zu sein
      // von hauptfermenter
      double kdis_default = 10.0;// 1000;// 0.25;// 150000; // _parameters[ADMparams.pos_kdis - 1];

      double Qsubstrate = math.sum(Q);

      if (Qsubstrate > 0)     // wenn der Fermenter gefüttert wird, dann kdis default Wert kleiner wählen
        kdis_default = Math.Max(0.25, kdis);

      // TODO : was ist wenn QdigesterIn == 0 ???

      kdis = Qsubstrate / QdigesterIn * kdis + ( 1 - Qsubstrate / QdigesterIn ) * kdis_default;

      // set disintegration constant
      if (kdis > 0 && ( Math.Abs(_parameters[ADMparams.pos_kdis - 1] - kdis) < 1 || start_of_simulation ))  
        _parameters[ADMparams.pos_kdis - 1] = kdis;

      // TODO
      // was besseres überlegen
      // 150000 stehen für Schlamm, welcher schon abgebaut wurde
      double khyd_ch_default = 10;// 150000; // _parameters[ADMparams.pos_khyd_ch - 1];
      double khyd_pr_default = 10;// 150000; // _parameters[ADMparams.pos_khyd_pr - 1];
      double khyd_li_default = 10;// 150000; // _parameters[ADMparams.pos_khyd_li - 1];

      if (Qsubstrate > 0)     // wenn der Fermenter gefüttert wird, dann khyd default Werte kleiner wählen
      {
        khyd_ch_default = Math.Max(10, khyd_ch);
        khyd_pr_default = Math.Max(10, khyd_pr);
        khyd_li_default = Math.Max(10, khyd_li);
      }

      khyd_ch = Qsubstrate / QdigesterIn * khyd_ch + (1 - Qsubstrate / QdigesterIn) * khyd_ch_default;
      khyd_pr = Qsubstrate / QdigesterIn * khyd_pr + (1 - Qsubstrate / QdigesterIn) * khyd_pr_default;
      khyd_li = Qsubstrate / QdigesterIn * khyd_li + (1 - Qsubstrate / QdigesterIn) * khyd_li_default;

      // set hydrolysis constants
      if (khyd_ch > 0 && (Math.Abs(_parameters[ADMparams.pos_khyd_ch - 1] - khyd_ch) < 1 || start_of_simulation ) )
        _parameters[ADMparams.pos_khyd_ch - 1] = khyd_ch;

      if (khyd_pr > 0 && (Math.Abs(_parameters[ADMparams.pos_khyd_pr - 1] - khyd_pr) < 1 || start_of_simulation ) )
        _parameters[ADMparams.pos_khyd_pr - 1] = khyd_pr;

      if (khyd_li > 0 && (Math.Abs(_parameters[ADMparams.pos_khyd_li - 1] - khyd_li) < 1 || start_of_simulation))
        _parameters[ADMparams.pos_khyd_li - 1] = khyd_li;

      // 

      return _parameters;
    }
    
    

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------



  }
}


