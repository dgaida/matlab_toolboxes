/**
 * This file is part of the partial class ADMstate and defines
 * all methods which have to do with the ADMstream.
 * 
 * TODOs:
 * - calcADMstream, ok
 * - Biomasse ausrechnen für Gülle Zufuhr (energy balance pdf lübken 2007), habe ich gemacht
 * - improve documentation
 * 
 * Except for that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;

namespace biogas
{
  /**
   * TODO: Implement: calcPHOfADMstate as in MATLAB, 
   * all other methods are as in MATLAB
   * 
   * 
   * References:
   * 
   * 1) Schoen, M.A., Sperl, D., Gadermaier, M., Goberna, M., Franke-Whittle, I.,
   *    Insam, H., Ablinger, J., and Wett B.: 
   *    Population dynamics at digester overload conditions, 
   *    Bioresource Technology 100, pp. 5648-5655, 2009
   * 
   * 
   * 
   *  %%
      % If you want to add noise to substrate params, do not do this in this
      % function nor in simulink. Better before the start of the simulation edit
      % the substrate xml file an load it again (should be done automatically at
      % the start of the simulation, to be checked) 
      %
      %%
      % Remarks:
      %
      % TKN consists of Ammonium + organic nitrogen (soluble + particulate).
      %
      % The TNb (total nitrogen) consists of Ammonium + nitrite + nitrate +
      % organic nitrogen (soluble + particulate) 
      %
      % So TNb= TKN + nitrite + nitrate
      %
      %
   * 
   * 
   *  % <html>
      % <ol>
      % <li> 
      % Copp, J.B.; Jeppsson, U. and Rosen, C.: 
      % <a href="matlab:feval(@open, 
      % eval('sprintf(''%s\\pdfs\\03 Towards an ASM1-ADM1 state variable interface for plant-wide WWT modeling.pdf'', 
      % biogas_blocks.getHelpPath())'))">
      % Towards an ASM1-ADM1 State Variable Interface for Plant-Wide Wastewater Treatment Modeling</a>, 
      % in Proceedings of the Water Environment Federation, WEFTEC 2003: Session
      % 51 through Session 60, pp. 498-510(13), 2003. 
      % </li>
      % <li> 
      % Nopens, I., Batstone, D.J., Copp, J.B., Jeppsson, U., Volcke, E., Alex,
      % J. and Vanrolleghem, P.A.: 
      % <a href="matlab:feval(@open, 
      % eval('sprintf(''%s\\pdfs\\09 An ASM ADM model interface for dynamic plant-wide simulation.pdf'', 
      % biogas_blocks.getHelpPath())'))">
      % An ASM/ADM model interface for dynamic plant-wide simulation</a>, 
      % in Water Research, 43:1919-1923, 2009.
      % </li>
      % <li> 
      % Zaher, U.; Li, R.; Jeppsson, U.; Steyer, J.-P.; Chen S.: 
      % <a href="matlab:feval(@open, 
      % eval('sprintf(''%s\\pdfs\\09 GISCOD - General Integrated Solid Waste Co-Digestion model.pdf'', 
      % biogas_blocks.getHelpPath())'))">
      % GISCOD: General Integrated Solid Waste Co-Digestion model</a>, 
      % in Water Research, 43:2717-2727, 2009.
      % </li>
      % </ol>
      % </html>
   * 
   */
  public partial class ADMstate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------
        
    /// <summary>
    /// Calculates the ADM stream for the given substrate
    /// </summary>
    /// <param name="mySubstrate"></param>
    /// <param name="Q">substrate feed in m^3/d</param>
    /// <returns></returns>
    public static double[] calcADMstream(biogas.substrate mySubstrate, double Q)
    {
      //physValue pCOD_S;   // COD in filtrate, not the soluble COD, but includes it
      
      //mySubstrate.get_params_of(out pCOD_S, "COD_S");

      //double COD_fil = pCOD_S.convertUnit("kgCOD/m^3").Value;    // COD in filtrate

      //physValue pNH4;

      //mySubstrate.get_params_of(out pNH4, "Snh4");
            
      double pH= mySubstrate.get_param_of("pH");

      // total carbonate alkalinity [mmol/l] == mol/m³
      //double TAC= mySubstrate.get_param_of("TAC");

      //double aScod= mySubstrate.get_param_of("aScod");

      //double COD_S= 0;

      //if (COD > 0)
      //  COD_S= aScod * COD;
      //else
      //  aScod= 0;

      // get f factors

      double fCH_XC, fPR_XC, fLI_XC, fXI_XC, fSI_XC, fXP_XC;

      mySubstrate.calcfFactors(out fCH_XC, out fPR_XC, out fLI_XC, out fXI_XC, out fSI_XC, out fXP_XC);

      //

      //double pSS_XS= 0.3;

      //double COD_SS= COD_S * pSS_XS;

      //double COD_SX= COD_S - COD_SS;

      //double COD_X= COD - COD_S;
      // Particulate COD [kgCOD/m^3]
      double COD_X = mySubstrate.calcXc().Value;

      //

      //physValue pSac, pSac_;
      //physValue pSpro, pSpro_;
      //physValue pSbu, pSbu_, pSva, pSva_;

      //mySubstrate.get_params_of(out pSac, "Sac", out pSac_, "Sac_");
      double Sac = mySubstrate.get_params_of("Sac").convertUnit("kgCOD/m^3").Value;

      //double SVFAtemp= COD_SS;
      
      //COD_SS= Math.Max(COD_SS - Sac, 0);

      //if (COD_SS == 0)
      //  Sac= SVFAtemp;

      double Sac_ = mySubstrate.get_params_of("Sac_").convertUnit("kgCOD/m^3").Value; 
      //Sac / (1 + Math.Pow(10, chemistry.pK_S_ac - pH));

      //

      //mySubstrate.get_params_of(out pSpro, "Spro", out pSpro_, "Spro_");
      double Spro = mySubstrate.get_params_of("Spro").convertUnit("kgCOD/m^3").Value;

      //SVFAtemp= COD_SS;

      //COD_SS= Math.Max(COD_SS - Spro, 0);

      //if (COD_SS == 0)
      //  Spro= SVFAtemp;

      double Spro_ = mySubstrate.get_params_of("Spro_").convertUnit("kgCOD/m^3").Value; 
      //Spro / (1 + Math.Pow(10, chemistry.pK_S_pro - pH));
      
      //

      //mySubstrate.get_params_of(out pSbu, "Sbu", out pSbu_, "Sbu_");
      double Sbu = mySubstrate.get_params_of("Sbu").convertUnit("kgCOD/m^3").Value;

      //SVFAtemp= COD_SS;

      //COD_SS= Math.Max(COD_SS - Sbu, 0);

      //if (COD_SS == 0)
      //  Sbu= SVFAtemp;

      double Sbu_ = mySubstrate.get_params_of("Sbu_").convertUnit("kgCOD/m^3").Value; 
      //Sbu / (1 + Math.Pow(10, chemistry.pK_S_bu - pH));
      
      // OK now. TODO: why is Sva always 0?

      //mySubstrate.get_params_of(out pSva, "Sva", out pSva_, "Sva_");
      double Sva = mySubstrate.get_params_of("Sva").convertUnit("kgCOD/m^3").Value;

      //SVFAtemp = COD_SS;

      //COD_SS = Math.Max(COD_SS - Sva, 0);

      //if (COD_SS == 0)
      //  Sva = SVFAtemp;

      double Sva_ = mySubstrate.get_params_of("Sva_").convertUnit("kgCOD/m^3").Value;
      // Sva / (1 + Math.Pow(10, chemistry.pK_S_va - pH));

      //

      double sum_f= fCH_XC + fLI_XC + fPR_XC;

      // lcfa in lipids
      double fFA_XLI= 0.95;

      //

      double Ssu= 0;
      
      //if (COD_SS > 0)
      //  Ssu= COD_SS * fCH_XC / sum_f + COD_SS * fLI_XC / sum_f * (1 - fFA_XLI);
      
      double Saa= 0;
      
      //if (COD_SS > 0)
      //  Saa= COD_SS * fPR_XC / sum_f;

      double Sfa= 0;

      //if (COD_SS > 0)
      //  Sfa= COD_SS * fLI_XC / sum_f * fFA_XLI;

      //

      double Sh2= 0;
      double Sch4= 0;



      //physValue pNH4;

      //mySubstrate.get_params_of(out pNH4, "Snh4");

      // NH4 in [gN/l]
      // Snh4 muss in [kmol N/m³]
      // g/l * 1000 l/m³ / 14 gN/mol * k/1000 = 1/14 * kmol N/m³
      // TODO: aktuell rechnet er mit faktor 14 + 4*1 = 18
      // wenn messwert tatsächlich als NH4-N vorliegt, dann müsste 14 genommen werden
      // wenn als NH4, dann ist 18 richtig, das ist zumindest meine vermutung
      // s. http://aquabaz.tripod.com/ammoniageneral.htm
      //double Snh4 = 0;// pNH4.convertUnit("kmol/m^3").Value;
      // wird über N_Xc berechnet, bzw. berücksichtigt

      double Snh4 = mySubstrate.get_params_of("Snh4").convertUnit("kmol/m^3").Value;



      //
      // SIin in gCOD/l
      double SI= mySubstrate.get_param_of("SIin");

      // particulate disintegrated COD 
      double COD_SX = mySubstrate.calcCOD_SX().Value;
        //Math.Max(COD_fil - Sva - Sbu - Spro - Sac, 0);

      // particulate non-disintegrated COD 
      double Xc= COD_X - COD_SX;

      //

      double Xch= 0;
      
      if (COD_SX > 0)
        Xch= COD_SX * fCH_XC / sum_f + COD_SX * fLI_XC / sum_f * (1 - fFA_XLI);

      double Xpr= 0;
      
      if (COD_SX > 0)
        Xpr= COD_SX * fPR_XC / sum_f;

      double Xli= 0;

      if (COD_SX > 0)
        Xli= COD_SX * fLI_XC / sum_f * fFA_XLI;


      double Xbacteria, Xmethan;
      mySubstrate.calcXbiomass(out Xbacteria, out Xmethan);      

      double Xsu= Xbacteria / 5.0f;
      double Xaa = Xbacteria / 5.0f;
      double Xfa = Xbacteria / 5.0f;
      double Xc4 = Xbacteria / 5.0f;
      double Xpro = Xbacteria / 5.0f;
      // nicht überlebensfähig unter sauerstoff, deshalb immer 0
      // Quelle???
      double Xac = Xmethan / 2.0f;
      double Xh2 = Xmethan / 2.0f;

      // reduziere total COD um biomasse
      Xc -= Xbacteria - Xmethan;

      //

      double XI= 0;	

      double Xp= 0;	

      // werden unten durch pH Wert Bestimmung gesetzt
      double Scat= 0;
      double San= 0;


      
      // TODO
      // vom TAC Wert müssen noch die Salze (bbzw. alle geladenen Teilchen)
      // abgezogen werden. s. Definiton von TAC!!!
      // in kmol/m³
      double Shco3 = mySubstrate.get_params_of("Shco3").convertUnit("kmol/m^3").Value;
      //Math.Max(TAC / 1000 - San - Sac_ / 64 - Spro_ / 112 - Sbu_ / 160 - Sva_ / 208 + Scat, 0);


      // TODO - test
      double Sco2 = mySubstrate.get_params_of("Sco2").convertUnit("kmol/m^3").Value;

      

      // aus Simba's asm12adm1xp Block kopiert

      //salk : Alkalinity von ASM1 kommend
      //snh: NH4(+) and NH3 nitrogen
      //sno: Nitrate and nitrite nitrogen

      //Sco2= 10^(6.3+log(salk)-pH)/1000

      //Shco3= (salk-dALK)/1000

      //dALK= (snh-SIN_-sno)/14

      //Inputbilanz:
      //TKN_= snh+snd+xnd+xbh*iXB+xba*iXB+xp*iXP+xi*iXI+si*iSI   

      //snd: Soluble biodegradable organic nitrogen
      //xnd: Particulate biodegradable organic nitrogen

      //Input - output
      //Ammonia + ammonium nitrogen: SIN_= TKN_-((XC_)*nXC+XP_*nXp+si*nI+XI_*nI+SAA_*nSAA)*14
      //SIN_= TKN – org. Stickstoff, OK



      //

      //double Snh3= 0;   // wird über N_Xc berechnet, bzw. berücksichtigt

      //double NH4= pNH4.convertUnit("g/m^3").Value;

      //if (Snh4 > 0)
      //  // formula comes from Simba block
      //  // ASM1m / ADM1xp block
      //  // TODO: in simba wird am Ende noch mal durch 14 geteilt, muss falsch sein
      //  //
      //  // diese Formel kann man folgendermaßen umstellen:
      //  //
      //  // Ammonia:
      //  //
      //  // Ebenfalls ein Säure-Basen GG zwischen Ammoniak und Ammonium
      //  //
      //  // pK_S := -log_10 (K_S) -> K_S= 10^(-pK_S)
      //  // pK_S= 9.25 für das GG
      //  //
      //  // pH := -log_10(c(H^+))
      //  // c(H^+)= 10^(-pH)
      //  //
      //  // K_S= \frac{c(H^+) \cdot c(NH_3)}{c(NH_4)}
      //  // 10^(-9.25)= \frac{10^(-pH) \cdot SNH_3}{SIN_}
      //  // 
      //  //
      //  // $SNH3(t)= \frac{ 10^{ \left( pH - 9 + \log_{10}( SIN\_(t) / 14 ) \right)
      //  // } }{1000 \cdot 14}  
      //  // ~~~~~~~~~~ \left[ \frac{k mol N}{m^3} \right]$
      //  //
      //  // log10((NH4 / 14) / (Snh3 * 1000)) = pH - 9
      //  // anstatt 9 eigentlich 9.25
      //  // 
      //  // TODO: Faktor 14 stimmt nicht mit dem überin was intern gerechnet wird,
      //  // intern wird 14+4*1 genommen
      //  // d.h. oben bei berechung von Sh4 wird die Annahme gemacht, dass NH4
      //  // in ammonium und nicht in ammonium nitrogen gemessen wird, muss deshalb auch hier so sein
      //  // momentan wird hier davon ausgegangen, dass NH4 ammonium nitrogen sei
      //  //Snh3= ( Math.Pow(10, pH - 9 + Math.Log10( NH4 / 14) ) ) / 1000;
      //  Snh3 = //(
      //    Math.Pow(10, pH - 9.25) * Snh4;// + Math.Log10( NH4 / 18) ) ) / 1000;
      //else
      //  // for log(0) = -Inf, log(-...) = complex solution
      //  Snh3 = 0;


      // TODO - delete
      // ne das bleibt, da fSIN_Xc= 0
      double Snh3 = mySubstrate.get_params_of("Snh3").convertUnit("kmol/m^3").Value;



      //
      // TODO: only works for ADM1xp model
      double[] x= {Ssu, Saa, Sfa, Sva, Sbu, Spro, Sac, Sh2, Sch4, Sco2,
                          Snh4, SI, Xc,  Xch, Xpr, Xli, Xsu, Xaa, Xfa, Xc4, 
                          Xpro,    Xac,  Xh2,   XI, Xp, Scat, San, Sva_, Sbu_, Spro_, 
                          Sac_, Shco3, Snh3, Q};

      // 

      // mol N / gCOD
      double fSIN_XC= mySubstrate.get_param_of_d("fSIN_Xc");

      physValue NH3= mySubstrate.get_params_of("Snh3");

      // mol N / l
      double NH4inXc = fSIN_XC * Xc - NH3.convertUnit("mol/l").Value;

      // TODO test
      //x = setPHOfADM1Stream(x, pH, NH4inXc);

      return x;
    }

    /// <summary>
    /// Set cations and anions, such that pH value of substrate feed is satisfied
    /// 
    /// damit cationen und anionen richtig gesetzt werden, 
    /// </summary>
    /// <param name="x"></param>
    /// <param name="pH">pH value</param>
    /// <param name="NH4inXc">nh4 in XC in mol/l</param>
    /// <returns></returns>
    public static double[] setPHOfADM1Stream(double[] x, double pH, double NH4inXc) // const
    {
      double Kw= 2.08e-14;

      // der Wert ist 0
      physValue Snh4= biogas.ADMstate.calcFromADMstate(x, "Snh4", "mol/l");

      // ist in der Regel negativ, da TAC meist größer als Snh4 ist
      // kann man für die Substrate mais und Gülle für BGA Geiger zumindest bestätigen
      // das Problem ist, dass TAC und NH4 nicht zu dem pH Wert passen, das heisst eines
      // von beiden muss verändert werden. hier ändere ich den TAC, da ich unten Scat bzw. San
      // ändere, damit verändert man auch TAC. es macht keinen sinn dann wieder Shco3, Sco2 zu ändern,
      // damit TAC wieder passt, da dann der pH Wert nicht mehr passt. 
      // mir scheint, dass es keine wirklich saubere lösung gibt, es läuft alles darauf hinaus
      // dass einer der beiden gemessenen Größen TAC und NH4 nicht stimmen, was irgendwie komisch
      // ist. 
      double pfac_h_current = -calcTACOfADMstate(x, "mol/l").Value + Snh4.Value;// + NH4inXc;

      double SH= Math.Pow(10, -pH);

      // dieser wert ist für pH Wert= 7 : 1.08e-7
      // pH 4: -1.0e-4
      // in jedem fall sehr klein, so dass pfac_h_current meist überwiegen sollte
      double pfac_h_setpoint= Kw/SH - SH;

      // d.h. Scatan ist meist positiv
      // wenn Scat gesetzt wird, sinkt allerdings der TAC Wert, s. Berechnung des TAC
      // wird dies kompensiert mit einer erhöhung des Shco3, dann 
      double Scatan= pfac_h_setpoint - pfac_h_current;

      if (Scatan > 0)
      {
        // Scat
        x[pos_Scat - 1] += Scatan;
      }
      else
      {
        // San
        x[pos_San - 1] += -Scatan;
      }


      // correct TAC value again by changing Shco3

      //x[pos_Shco3 - 1]+= -Scatan;

      //x[pos_Shco3 - 1] = Math.Max(x[pos_Shco3 - 1], 0);

      //if (x[pos_Shco3 - 1] > 0)
      //  x[pos_Sco2 - 1] = Math.Pow(10, 6.3 - pH) * x[pos_Shco3 - 1];
      //else
      //  x[pos_Sco2 - 1] = 0;
    
      //

      return x;
    }



    /// <summary>
    /// calculates ADMstream mix of substrates for each digester
    /// and measures in the mix of all digesters together the COD SS and VS 
    /// content.
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="myPlant"></param>
    /// <param name="substrate_network"></param>
    /// <param name="mySensors"></param>
    /// <param name="dilution_rates">double vector with the wanted dilution rates for each digester.
    /// Could be given by a dilution rate control. The size of the vector must
    /// be equal to number of digesters.</param>
    /// <returns></returns>
    public static double[] calc_measureADMstreamMix(double t, biogas.substrates mySubstrates,
                           biogas.plant myPlant, double[,] substrate_network,
                           biogas.sensors mySensors, //double deltatime,
                           double[] dilution_rates)
    {
      double[] mystream = calcADMstreamMix(t, mySubstrates, myPlant, substrate_network, 
        mySensors, dilution_rates);

      //

      double[] mixed_stream = mixADMstreams(mystream);

      // measure COD SS and VS of mixed stream
      
      // TODO : evtl. von total_mix in substratemix umbenennen
      // muss dann auch überall anders gemacht werden. bsp: objectives und
      // sensors: create_sensor_network

      mySensors.measure(t, "SS_COD_total_mix_2", mixed_stream);

      mySensors.measure(t, "VS_COD_total_mix_2", mixed_stream);

      mySensors.measure(t, "Q_total_mix_2", mixed_stream);

      // messe VS in Substratzufuhr
      mySensors.measure(t, "VS_total_mix_2", mixed_stream, mySubstrates);

      return mystream;
    }

    /// <summary>
    /// Calc mix of substrates for all digesters
    /// 
    /// Q is gotten out of sensor
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="myPlant"></param>
    /// <param name="substrate_network"></param>
    /// <param name="mySensors"></param>
    /// <param name="dilution_rates">double vector with the wanted dilution rates for each digester.
    /// Could be given by a dilution rate control. The size of the vector must
    /// be equal to number of digesters.</param>
    /// <returns>a column vector with dimension equal to dim_stream * n_digester</returns>
    public static double[] calcADMstreamMix(double t, biogas.substrates mySubstrates,
                           biogas.plant myPlant, double[,] substrate_network,
                           biogas.sensors mySensors, //double deltatime,
                           double[] dilution_rates)
    {
      double[] Q;

      mySensors.getMeasurementsAt("Q", "Q", t, mySubstrates, out Q);

      return calcADMstreamMix(t, mySubstrates, myPlant, substrate_network, mySensors, 
        Q, dilution_rates);
    }

    /// <summary>
    /// Calc mix of substrates for all digesters
    /// 
    /// TODO: s. auch in funktion unten
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="myPlant"></param>
    /// <param name="substrate_network"></param>
    /// <param name="mySensors"></param>
    /// <param name="Q">only used if datasource_type == extern</param>
    /// <param name="dilution_rates">double vector with the wanted dilution rates for each digester.
    /// Could be given by a dilution rate control. The size of the vector must
    /// be equal to number of digesters.</param>
    /// <returns>[34dim stream for digester1; 34dim stream for digester2; ...]</returns>
    public static double[] calcADMstreamMix(double t, biogas.substrates mySubstrates,
                           biogas.plant myPlant, double[,] substrate_network,
                           biogas.sensors mySensors, double[] Q, //double deltatime, 
                           double[] dilution_rates)
    {
      double[,] myStreams = new double[biogas.ADMstate._dim_stream, myPlant.getNumDigesters()];

      for (int idigester = 0; idigester < myPlant.getNumDigesters(); idigester++)
      {
        double Vliq = myPlant.getDigesterParam(idigester + 1, "Vliq");

        // D ist < 0, wenn Anlage nicht geregelt wird
        double D = dilution_rates[idigester];

        double Q_new = D * Vliq;

        myStreams = math.insertColumn(myStreams, 
                    calcADMstreamMixForDigester(t, mySubstrates, substrate_network, mySensors, 
                                                idigester, Q, Q_new), 
                    0, idigester);
                
        // measure energy needed to transport substrates
        biogas.substrate_transport.run(t, mySensors,
          "substratemix", myPlant.getDigesterID(idigester + 1), myPlant, mySubstrates,
          substrate_network);
      }

      double[] myStream = math.concat(myStreams);

      return myStream;
    }
    
    /// <summary>
    /// Calculates the ADM input mix for the given digester
    /// 
    /// OK, s. oben: diese Funktion noch überladen, ohne Q, aber mit sensors
    /// dann wird Q aus sensor geholt, mit übergabe von t
    /// 
    /// OK, ist drin: was ist mit substrate parameter, müsste auch hier rein, oder?
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <param name="mySensors"></param>
    /// <param name="digester_index">0-based</param>
    /// <param name="Q">Q for each substrate for total plant</param>
    /// <param name="Q_new">wanted total substrate feed into digester, in m^3/d</param>
    public static double[] calcADMstreamMixForDigester(double t, biogas.substrates mySubstrates,
      double[,] substrate_network, biogas.sensors mySensors, int digester_index, double[] Q, 
      double Q_new)
    {

      int isubstrate = 0;

      // normalize substrate_network
      double[,] norm_substrate_network = math.normalize(substrate_network, 1);

      //

      double[] substrate_network_digester =
        science.math.getcol(norm_substrate_network, digester_index);

      //
      // total feed into digester
      double myQ = science.math.mtimes(substrate_network_digester, Q);
      double myQnew = myQ;

      // 
      if (Q_new >= 0) // wenn es < 0 wäre, dann wäre der Fermenter nicht geregelt
      {
        myQnew= Q_new;
      }

      //

      double[,] myStreams = new double[biogas.ADMstate._dim_stream, mySubstrates.getNumSubstrates()];

      foreach (biogas.substrate mySubstrate in mySubstrates)
      {
        // change params of substrate
        biogas.substrateparams_sensor.set_substrate_params_from_sensor(t, mySensors, 
                                                                       mySubstrate);

        // Q of substrate
        double Q_subs= Q[isubstrate] * substrate_network_digester[isubstrate];

        if (myQ > 0)
          Q_subs = Q_subs * myQnew / myQ;

        // calc ADM stream out of substrate
        myStreams= math.insertColumn(myStreams, calcADMstream(mySubstrate, Q_subs), 0, isubstrate);        
        
        isubstrate++;
      }

      return mixADMstreams(myStreams);

      

      //if strcmp(substrate_name, 'futterkalk')
  
      //  % CO2 auf - Hco3/2 setzen
      //  % da durch zugabe von CaCO3 Co2 abgebaut wird und reagiert zu zweifacher
      //  % menge von Hco3 und Ca2+
      //  y_adm1xp(10)= -y_adm1xp(32) / 2;
      //  %y_adm1xp(26)= 0;
        
      //end
    }


    
    /// <summary>
    /// Mix a stream of N ADM streams
    /// </summary>
    /// <param name="y_adm1xpN">the ADM streams are given row wise
    /// the number of columns is given by the number of N</param>
    /// <returns></returns>
    public static double[] mixADMstreams(double[,] y_adm1xpN)
    {
      //double[] y_adm1xpN_v= new double[y_adm1xpN.Length];

      //// the ADM streams are concatenated row wise
      //// the returned ADM stream has N times stream_size rows
      //for (int irow= 0; irow < y_adm1xpN.GetLength(0); irow++ )
      //{
      //  for (int icol= 0; icol < y_adm1xpN.GetLength(1); icol++ )
      //  {
      //    y_adm1xpN_v[irow + icol*y_adm1xpN.GetLength(0)]= y_adm1xpN[irow, icol];
      //  }
      //}

      return mixADMstreams( math.concat(y_adm1xpN) );
    }
    /// <summary>
    /// Mix a stream of N ADM streams.
    /// Because of this function pos_Q must always be at the end of the stream.
    /// </summary>
    /// <param name="y_adm1xpN">the ADM streams are concatenated row wise
    /// the ADM stream must have N times stream_size rows</param>
    /// <returns></returns>
    public static double[] mixADMstreams(double[] y_adm1xpN)
    { 
      int n_inputs= y_adm1xpN.Length / _dim_stream;

      double q_sum= 0;    // total feed in m³/d

      for (int iq= pos_Q - 1; iq < pos_Q * n_inputs; iq= iq + pos_Q)
        q_sum+= y_adm1xpN[iq];

      double[,] stream= new double[n_inputs, _dim_stream - 1];

      for (int istream= 0; istream < n_inputs; istream++)
      {

        if (q_sum != 0)
        {
          for (int icol= 0; icol < pos_Q - 1; icol++)
            stream[istream, icol]= y_adm1xpN[_dim_stream * istream + icol] * 
                                   y_adm1xpN[pos_Q * (istream + 1) - 1] / q_sum;
        }
        else
        {
          for (int icol= 0; icol < pos_Q - 1; icol++)
            stream[istream, icol]= 0;
        }

      }

      double[] y_adm1xp= new double[_dim_stream];

      double[] y_adm1xp_1= math.sum(stream, 0);

      for (int icomp= 0; icomp < _dim_stream - 1; icomp++)
        y_adm1xp[icomp]= y_adm1xp_1[icomp];

      y_adm1xp[pos_Q - 1]= q_sum;

      return y_adm1xp;
    }



  }
}


