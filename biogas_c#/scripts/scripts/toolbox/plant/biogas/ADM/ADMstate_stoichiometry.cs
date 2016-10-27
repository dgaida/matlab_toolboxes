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
* This file is part of the partial class ADMstate and defines
* the makeStoichiometry method.
* 
* TODOs:
* - improve documentation
* - add Vgas(t) and Vliq(t) to state vector x. insbesondere Vgas(t) wäre
*   wichtig um gasspeicher von BGA zu simulieren. gasspeicher kann man wie ein 
*   RÜB simulieren. ich habe dazu auch einige notizen gemacht wie man das am besten 
*   macht
* 
* Except for that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
//using MathWorks.MATLAB.NET.Arrays;

namespace biogas
{
  /**
   * TODO: 
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
   * 
   * %% TODO

% if exist(sprintf('reference_%s_gaslevel.mat', fermenter_id), 'file')
% 
%   ref_gaslevel= load_file(sprintf('reference_%s_gaslevel.mat', fermenter_id));
%   
%   [c_t, in_c_t]= min(abs(ref_gaslevel(1,:) - t));
%   
%   Vgas= max(ref_gaslevel(2, in_c_t), 1);
%   
%   plant.myDigesters.getByID(fermenter_id).set_params_of('Vgas', Vgas);
%   
% end
% 
% if exist(sprintf('reference_%s_level.mat', fermenter_id), 'file')
% 
%   ref_level= load_file(sprintf('reference_%s_level.mat', fermenter_id));
%   
%   [c_t, in_c_t]= min(abs(ref_level(1,:) - t));
%   
%   Vliq= max(ref_level(2, in_c_t), 100);
%   
%   plant.myDigesters.getByID(fermenter_id).set_params_of('Vliq', Vliq);
%   
% end

   * 
   * 
   * 
   * 
   */
  public partial class ADMstate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="t"></param>
    /// <param name="x"></param>
    /// <param name="u"></param>
    /// <param name="digester_id"></param>
    /// <param name="mySensors"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <param name="plant_network"></param>
    /// <returns></returns>
    public static double[] getADM1output(double t, double[] x, double[] u,
      string digester_id, //double deltatime, 
      biogas.sensors mySensors,
      biogas.plant myPlant, biogas.substrates mySubstrates, 
      double[,] substrate_network, double[,] plant_network)
    {
      // measure VS in input stream u
      mySensors.measure(t, "VS_" + digester_id + "_2", u, mySubstrates);

      // x and u are changed by this call
      double[] ADM1output = getADM1output(t, x, u, digester_id, mySensors, myPlant);

      // measure in output stream x, which was changed by the called function above
      // volumeflow in x was changed

      // TS, (density) and OLR and stirrer
      mySensors.measure_type7(t, x,
        myPlant, mySubstrates, mySensors, substrate_network, plant_network,
        digester_id);

      // measure VS in output stream x
      mySensors.measure(t, "VS_" + digester_id + "_3", x, mySubstrates);


      // if digester is heated, calculate heat energy
      // user can check whether digester is heated or not
      // is set in ADM1.m

      // returns 4dim vector
      // 1st element: heat consumption due to heating of substrates
      // 2nd element: heat consumption due to radiation loss
      // 3rd: heat prod. microbiology
      // 4th: heat prod. stirrer diss.
      // 
      // damit dieser sensor richtig misst, muss hier auch substrate_network 
      // übergeben werden, damit nur die substrate geheizt werden
      // welche tatsächlich in diesen fermenter rein gehen
      // s. getSubstrateMixFlowForFermenter
      //
      // ist jetzt ein typ 7 sensor
      //
      //mySensors.measureVec( t, "heatConsumption_" + digester_id,
      //                      deltatime, x, myPlant, mySubstrates, mySensors, 
      //                      substrate_network, digester_id );

      //

      return ADM1output;
    }

    /// <summary>
    /// TODO
    /// </summary>
    /// <param name="t"></param>
    /// <param name="x">dim_state dimensional state vector</param>
    /// <param name="u"></param>
    /// <param name="digester_id"></param>
    /// <param name="mySensors"></param>
    /// <param name="myPlant"></param>
    /// <returns></returns>
    public static double[] getADM1output(double t, double[] x, double[] u,
      string digester_id, //double deltatime, 
      biogas.sensors mySensors, 
      biogas.plant myPlant)
    {
      // measure in the in- and output stream of the ADM1
      // we measure in original u not in u_new
      // last argument 2 is for "in"
      mySensors.measure_type0(t, u, digester_id, 2);

      // 
      mySensors.measure(t, "Norg_" + digester_id + "_2", myPlant, u);
      mySensors.measure(t, "TKN_" + digester_id + "_2", myPlant, u);
      mySensors.measure(t, "Ntot_" + digester_id + "_2", myPlant, u);
      mySensors.measure(t, "Snh4_" + digester_id + "_2", myPlant, u);
      mySensors.measure(t, "Snh3_" + digester_id + "_2", myPlant, u);

      // TODO: Vorsicht: u wird in dem Call geändert, deshalb wird u vorher gemessen
      // get correct Q output [m^3/d]
      // hat hier nur einen hydraulischen effekt, unten in anderer funktion
      // hat u auch einen biologischen effekt
      double[] u_new = adapt_inputstream_for_mass_conservation(u, digester_id, mySensors);

      // das wird vermutlich biogas m^3/d für 3 gase und dann noch mal in % sein
      double[] biogas_v;
      
      mySensors.getCurrentMeasurementVectorD("biogas_" + digester_id, out biogas_v);

      // measure state vector of ADM in default units of the model, hier wird 37 dim Vektor gemessen
      // erst hier nach pos_Q überschreiben
      mySensors.measure(t, "ADMstate_" + digester_id, x);

      // TODO - macht eigentlich keinen Sinn in x u_new zu schreiben, da x 37 dimensional
      // ist, d.h. wir überschreiben eine größe. welche an pos. 34 ist. eine gaskomponente
      // partial druck, aber OK
      x[pos_Q - 1] = u_new[pos_Q - 1];



      // TODO - test
      // gleicher Ausdruck steht auch noch mal weiter unten in einer Methode

      //try
      //{
      //  if (digester_id == "digester")
      //  {
      //    string pump_id = biogas.pump.getid("digester", "postdigester");

      //    // determine Q
      //    double Q_pump;      // to be pumped amount

      //    mySensors.getMeasurementAt("Q", "Q_" + pump_id, t, out Q_pump);

      //    x[pos_Q - 1] = Q_pump;    // das ist der gewünschte Ausfluss aus dem Hauptfermenter
      //    // u_new oben kompensiert nur für Biogas abgang
      //  }
      //}
      //catch (exception e)
      //{

      //}


      
      // ADM output should not contain intvars
      double[] ADM1output= new double[ADMstate._dim_stream + (int)BioGas.n_gases];//intvars.Length];

      ADM1output = math.insert(ADM1output, math.getrows(x, 0, ADMstate._dim_stream - 1), 0);

      ADM1output = math.insert(ADM1output, math.getrows(biogas_v, 0, (int)BioGas.n_gases - 1), pos_Q);


      
      // last argument 3 is for "out"
      mySensors.measure_type0(t, math.getrows(x, 0, _dim_stream - 1), digester_id, 3);


      // 
      mySensors.measure(t, "Norg_" + digester_id + "_3", myPlant, x);
      mySensors.measure(t, "TKN_" + digester_id + "_3", myPlant, x);
      mySensors.measure(t, "Ntot_" + digester_id + "_3", myPlant, x);
      mySensors.measure(t, "Snh4_" + digester_id + "_3", myPlant, x);
      mySensors.measure(t, "Snh3_" + digester_id + "_3", myPlant, x);

      // measure HRT in days from output, berechnung vom ausgang her, ähnlich wie
      // BWE, nicht ebrechnung vom eingang her, evtl. sollte man für HRT auch zwei
      // definitionen anbieten und mit in, out (2,3) bezeichnen?

      double Vliq= myPlant.getDigesterParam(digester_id, "Vliq");

      // HRT wird am Ausgang gemessen, so wie BWE das macht
      // in meiner thesis ist es für eingang definiert
      mySensors.measure(t, "HRT_" + digester_id, x, Vliq);

      // call here faecal sensor

      double Tdig = myPlant.getDigesterParam(digester_id, "T");
      double HRT;
      mySensors.getCurrentMeasurementD("HRT_" + digester_id, out HRT);

      mySensors.measure(t, "faecal_" + digester_id, x, HRT, Tdig);


      //

      return ADM1output;
    }

    /// <summary>
    /// calc x' for ADM1 model
    /// </summary>
    /// <param name="t">current simulation time in days</param>
    /// <param name="x">current ADM state vector</param>
    /// <param name="u">current ADM1 input stream</param>
    /// <param name="digester_id"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <param name="mySensors"></param>
    /// <returns></returns>
    public static double[] calc_xdot(double t, double[] x, double[] u, 
      string digester_id, biogas.plant myPlant,
      biogas.substrates mySubstrates, double[,] substrate_network,
      biogas.sensors mySensors/*, double deltatime*/)
    { 
      // adapt u to get correct u and correct input concentration

      // so lassen, hier nicht u verändern, sondern nur in der funktion oben
      // d.h. nur hydraulische auswirkung und keine biochemische.
      // das problem ist, dass sonst das gleichgewicht zwischen inputstoffen
      // und heraus gehenden stoffen nicht mehr passt und es zu einer akkumulation von
      // stoffen im fermenter kommt, dann müsste man alle parameter intern ändern
      // aber richtiger wäre es vermutlich schon...

      // TODO - outcomment - in ADM1DE block müssen noch Änderungen gemacht werden
      // wenn das klappt, dann kann Vliq dynamisch simuliert werden. erstmal
      // Vliq einfach so modellieren, später evtl. auch in ADM1 berücksichtigen
      // verlangsamt allerdigns modell
      // so wie es jetzt implementiert ist, bleibt Vliq constant, da das was rein geht
      // so groß ist wie das was raus geht (biogas + schlamm)
      // wenn unten qout sich mal ändern sollte, dann wird Vliq dynamisch
      //u= adapt_inputstream_for_mass_conservation(u, digester_id, mySensors);


      // q: volume flow [m^3/d]
      double qin= u[biogas.ADMstate.pos_Q - 1];

      physValue pVliq, pVgas;

      biogas.digester myDigester = myPlant.getDigesterByID(digester_id);

      myDigester.get_params_of(out pVliq, "Vliq", out pVgas, "Vgas");

      double Vliq = pVliq.Value;
      double Vgas = pVgas.Value;

      double[,] A, G;
      double[] p, rho;

      makeStoichiometry(x, t, digester_id, myPlant, mySubstrates, substrate_network, 
        mySensors, out A, out p, out G, out rho);

      //

      //measureProdEnergyOfMicroOrganisms(mySensors, p, Vliq);
      mySensors.measure(t, "energyProdMicro_" + digester_id, p, Vliq);

      // TODO
      // an dieser stelle darf nicht mit qin und u gerechnet werden, diese müssen
      // vorher runter gerechnet werden, wegen Masseverlust über biogasproduktion
      // es gehen auch weniger strom aus der anlage raus als wie qin

      double[] xdot= new double[37];

      double[] Ap= math.mtimes(math.transpose(A), p);     // A'*p

      double D= qin/Vliq;

      // accumulation of particulate solids
      double accum_x = myDigester.get_param_of_d("accum_x");
      // accumulation of soluble solids
      double accum_s = myDigester.get_param_of_d("accum_s");

      // dilution rate for output : SRT := 1 / Dout
      double Dout_x = D * accum_x;

      double Dout_s = D * accum_s;



      // TODO - test

      //try
      //{
      //  if (digester_id == "digester")
      //  {
      //    string pump_id = biogas.pump.getid("digester", "postdigester");

      //    // determine Q
      //    double Q_pump;      // to be pumped amount

      //    mySensors.getMeasurementAt("Q", "Q_" + pump_id, t, out Q_pump);

      //    Dout_x = Q_pump / Vliq;
      //    Dout_s = Q_pump / Vliq;
      //  }
      //}
      //catch (exception e)
      //{ 
              
      //}

      //


            
      double[] myvec_D_x = Array.ConvertAll<bool, double>(
        ADMstate.is_x, new Converter<bool, double>(
          delegate(bool b) 
          { 
            return Convert.ToDouble(b); 
          }));

      double[] myvec_D_s = Array.ConvertAll<bool, double>(
        math.not(ADMstate.is_x), new Converter<bool, double>(
          delegate(bool b)
          {
            return Convert.ToDouble(b);
          }));

      double[] vec_D_x = math.mtimes(math.diag(myvec_D_x), math.getrows(x, 0, 32));
      double[] vec_D_s = math.mtimes(math.diag(myvec_D_s), math.getrows(x, 0, 32));
      
      // TODO
      // in zukunft sollte man komplett selbst bestimmen können wie groß
      // der auslauf aus einem fermenter sein soll
      // dazu einfach D für ausgang verändern. es macht keinen unterschied ob 
      // man qout verändert oder das was rausgeht teilweise wieder in qin rein
      // steckt, d.h. rezirkuliert.
      // deshalb einfach qout über ein volumeflow_file.mat bestimmen
      
      // sys(1:33, 1)= qin/Vliq .* u(1:33,1) - qin/Vliq .* x(1:33,1) + A'*p;
      xdot= math.insert(xdot, math.plus( 
                                math.minus( math.times(D   , math.getrows(u, 0, 32)), 
                                    math.plus(
                                            math.times(Dout_x, vec_D_x), 
                                            math.times(Dout_s, vec_D_s) 
                                             )
                                          ), 
                                Ap), 0);

      // sys(34:37,1)= G'*rho;
      xdot= math.insert(xdot, math.mtimes(math.transpose(G), rho), 33);     // G'*rho;

      // sys(8:10,1)= sys(8:10,1) - ( Vgas / Vliq .* eye(3,3) )' * rho(1:3,1);
      xdot= math.insert(xdot, 
              math.minus( math.getrows(xdot, 7, 9),
                            math.mtimes(
                                math.times( Vgas / Vliq, math.eye(3,3) ), 
                                math.getrows(rho, 0, 2)
                                       )
                        ), 7 
                       );

      //

      return xdot;
    }

    /// <summary>
    /// Calculates the heat (thermal) energy produced by bacteria inside the digester 
    /// measured in kWh/d. Achtung das ist eine thermische energie, keine elektrische.
    /// 
    /// Der Wert wird als Energie PRODUKTION verstanden, d.h. ein positiver Wert 
    /// bedeutet, dass bakterien therm. energie produziert haben.
    /// ein negativer wert würde bedeuten, dass bakterien therm. energie verbruacht hätten.
    /// in der fitness funktion in objectives wird dieser wert als energieverbrauch
    /// gesehen, deshalb wird dort wieder das VZ gedreht.
    /// in ref. ist das VZ einmal verkehrt
    /// 
    /// reference: Modeling the energy balance of an anaerobic digester fed ...
    /// Lübken, 2007
    /// </summary>
    /// <param name="p">reaction rates vector of ADM1</param>
    /// <param name="Vliq">volume of digester in m^3</param>
    /// <returns>in kWh/d</returns>
    public static double calcProdEnergyOfMicroOrganisms(double[] p, double Vliq)
    {
      double energy = 0;

      // Delta energies measured in kJ/mol
      // values are taken from the reference
      // wenn Delta E < 0 ist, dann wird Energie frei gesetzt -> exotherm
      // wenn Delta E > 0 ist, dann wird Energie aufgenommen  -> endotherm
      // Gibbs-Helmholtz-Gleichung
      // http://de.wikipedia.org/wiki/Gibbs-Helmholtz-Gleichung
      // http://de.wikipedia.org/wiki/Exotherm
      double[] deltaE= {0.5*(-25.53) + 0.35*(-246.69) + 0.15*(-121.70), 
                        -36.46, 494.88, 89.99, 83.67, 90.87, -27.34, -18.86};

      for (int ireaction = 4; ireaction < 12; ireaction++)
      {
        // measured in mol / gCOD
        double fj= 1 / chemistry.get_COD_of(ADMstate.symADMstate[ireaction - 4]).Value;

        energy += deltaE[ireaction - 4] * fj * p[ireaction] * Vliq * 1/3.6;
      }

      // liefere negative energie zurück, da wenn energy negativ ist, dann
      // ist die rekation insgesamt exotherm. d.h. es wird energie produziert
      // und produzierte energie ist im modell positiv.
      // energie welche entweicht ist negativ -> endotherm muss also hier pos. sein
      return -energy;
    }

    /// <summary>
    /// Quelle: Lübken, S. 78 ff.
    /// Mathematical modeling of anaerobic digestion processes
    /// </summary>
    /// <param name="u">34 dim input stream vector</param>
    /// <param name="digester_id">id of digester</param>
    /// <param name="mySensors"></param>
    /// <returns></returns>
    public static double[] adapt_inputstream_for_mass_conservation(double[] u,
      string digester_id, biogas.sensors mySensors)
    {
      // TODO : could also be private

      // kg/m^3
      double rho;

      // density of the feed going into given digester
      mySensors.getCurrentMeasurementD("density_" + digester_id, out rho);

      // q: volume flow [m^3/d]
      double qin = u[biogas.ADMstate.pos_Q - 1];

      // m^3/d * (kg/m^3) * 1 t/1000 kg = t / d
      double m_influent = qin * rho / 1000;

      biogas_sensor myBiogasSensor = (biogas_sensor)mySensors.get("biogas_" + digester_id);

      // beta_ch4 : ch4 content in biogas [%]
      // beta_co2 : CO2 content in biogas [%], 
      // Qbiogas : total biogas stream for digester [m^3/d]
      double beta_ch4, beta_co2, Qbiogas;

      myBiogasSensor.getCurrentMeasurement("CH4_%", out beta_ch4);

      beta_ch4 /= 100;    // from [%] to [100 %]
      
      myBiogasSensor.getCurrentMeasurement("CO2_%", out beta_co2);

      beta_co2 /= 100;    // from [%] to [100 %]

      myBiogasSensor.getCurrentMeasurement("biogas_m3_d", out Qbiogas);

      // [t/d]
      //
      // original formula:
      //
      // mgas [g/d] = Qgas [l/d] * ( ( beta_ch4 * Mch4 + beta_co2 * Mco2 ) * 1/Vm + mH2O )
      //
      // Mch4 : molar mass of CH4 [g/mol]   12 + 4*1 g/mol = 16 g/mol
      // Mco2 : molar mass of CO2 [g/mol]   12 + 2*16 g/mol = 44 g/mol
      // mH2O [g/l] : mass of water vapor = 0.0488 g/l (water saturated)
      //
      // molares Normvolumen Vm= 22.4 l/mol
      //
      // TODO: gibt es auch in chemistry_properties.cs aber mit Wert
      // 24.465 l/mol
      //
      // [t/d] = [m^3/d] * (g / mol * mol/l + g/l) * kg/1000g * 1000l/m^3 * 1t/1000kg
      // t/d = m^3/d * g/l * kg/g * l/m^3 * t/kg/1000
      // t/d = t/d * 1/1000
      //
      //
      double m_gas = Qbiogas * ( 
        ( beta_ch4 * biogas.chemistry.get_mol_mass_of("Sch4").Value + 
          beta_co2 * biogas.chemistry.get_mol_mass_of("Sco2").Value 
        ) * 1 / (22.4) + 0.0488 ) / 1000;

      double fmass = 1;

      // m_influentnew= m_influent - m_gas
      // = m_influent * ( 1 - m_gas / m_influent )
      // = m_influent * f_mass
      //
      if (m_influent > 0)
        fmass = 1 - m_gas / m_influent;

      double qin_new = qin * fmass;

      double[] u_new;

      if (fmass <= 0)
      {
        // throw error
        // in the begining of a simulation it could happen, that fmass < 0
        //throw new exception(String.Format(
        //"adapt_inputstream_for_mass_conservation: fmass <= 0: {0}!", fmass));

        u_new = u;
      }
      else
      {
        u_new = math.times(1 / fmass, u);

        u_new[biogas.ADMstate.pos_Q - 1] = qin_new;
      }

      return u_new;
    }

    /// <summary>
    /// TODO documentation
    /// </summary>
    /// <param name="x">current ADM state vector</param>
    /// <param name="t">current simulation time in days</param>
    /// <param name="digester_id"></param>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="substrate_network"></param>
    /// <param name="mySensors"></param>
    /// <param name="A"></param>
    /// <param name="p"></param>
    /// <param name="G"></param>
    /// <param name="rho"></param>
    public static void makeStoichiometry(double[] x, double t, string digester_id, biogas.plant myPlant, 
                                         biogas.substrates mySubstrates, double[,] substrate_network, 
                                         biogas.sensors mySensors, //double deltatime, 
                                         out double[,] A, out double[] p, 
                                         out double[,] G, out double[] rho)
    { 
      // all will be measured in m³/d
      double Qgas_h2, Qgas_ch4, Qgas_co2, Qgas;

      // get params Vliq and T_deg

      biogas.digester myDigester= myPlant.getDigesterByID(digester_id);

      physValue Vliq, T_deg;

      myDigester.get_params_of(out Vliq, "Vliq", out T_deg, "T");

      T_deg= T_deg.convertUnit("°C");

      // calc biogas flow out of given ADM state
      biogas.ADMstate.calcBiogasOfADMstate(x, Vliq, T_deg, out Qgas_h2, out Qgas_ch4, 
                                                           out Qgas_co2, out Qgas);

      //

      // measure biogas
      // TODO - wenn anzahl gemessener gase sich ändert, dann hier ändern
      double[] ugas = { Qgas_h2, Qgas_ch4, Qgas_co2 };

      mySensors.measureVec(t, "biogas_" + digester_id, ugas);

      //

      physValue T_K= T_deg.convertUnit("K");

      double RT= biogas.chemistry.R.Value * T_K.Value;
      
      double pext= biogas.chemistry.pAtm.Value - 0.0084147 * Math.Exp(0.054 * T_deg.Value);

      double kp= biogas.digester.kp.Value;
               
      //

      double Ssu, Saa, Sfa, Sva, Sbu, Spro, Sac, Sh2, Sch4, Sco2, 
             Snh4, SI, Xc, Xch, Xpr, Xli, Xsu, Xaa, Xfa, Xc4, 
             Xpro, Xac, Xh2, XI, Xp, Scat, San, Sva_, Sbu_, Spro_, 
             Sac_, Shco3, Snh3;

      // TODO - write this method, which returns all state vector
      // components via out
      //[Ssu, Saa, Sfa, Sva, Sbu, Spro, Sac, Sh2, Sch4, Sco2, 
      //      Snh4, SI, Xc, Xch, Xpr, Xli, Xsu, Xaa, Xfa, Xc4, 
      //      Xpro, Xac, Xh2, XI, Xp, Scat, San, Sva_, Sbu_, Spro_, 
      //      Sac_, Shco3, Snh3]= biogas.ADMstate.getADMstatevariables(x);

      // monosaccarides [kg COD/m^3]
      Ssu= x[0];
      // amino acids [kg COD/m3]
      Saa= x[1];
      // total LCFA [kg COD/m3]
      Sfa= x[2];
      // valeric acid + valerate kg COD/m3 
      Sva= x[3];
      // butyric acid + butyrate kg COD/m3 
      Sbu= x[4];
      // propionic acid + propionate kg COD/m3 
      Spro= x[5];
      // acetic acid + acetate kg COD/m3 
      Sac= x[6];
      // hydrogen kg COD/m3 
      Sh2= x[7];
      // methane kg COD/m3 
      Sch4= x[8];
      // carbon dioxide k mol C/m3 
      Sco2= x[9];
      // Ammonium k mol N/m3 
      Snh4= x[10];
      // soluble inerts kg COD/m3 
      // TODO: Beispiel?
      SI= x[11];
      // composite kg COD/m3 
      Xc= x[12];
      // carbohydrates kg COD/m3 
      Xch= x[13];
      // proteins kg COD/m3 
      Xpr= x[14];
      // lipids [kg COD/m^3]
      Xli= x[15];
      // Biomass Sugar degraders kg COD/m3 
      Xsu= x[16];
      // Biomass amino acids degraders kg COD/m3 
      Xaa= x[17];
      // Biomass LCFA degraders kg COD/m3 
      Xfa= x[18];
      // Biomass valerate, butyrate degraders kg COD/m3 
      Xc4= x[19];
      // Biomass propionate degraders kg COD/m3 
      Xpro= x[20];
      // Biomas acetate degraders kg COD/m3 
      Xac= x[21];
      // Biomass hydrogen degraders kg COD/m3 
      Xh2= x[22];
      // particulate inerts kg COD/m3 
      // TODO: Beispiel?
      XI= x[23];
      // Particulate products arising from biomass decay kg COD/m^3 
      Xp= x[24];
      // cations k mol/m3 
      Scat= x[25];
      // Anions k mol/m3 
      San= x[26];
      // valerate kg COD/m3 
      Sva_= x[27];
      // Butyrate kg COD/m3 
      Sbu_= x[28];
      // propionate kg COD/m3 
      Spro_= x[29];
      // acetate kg COD/m3 
      Sac_= x[30];
      // bicarbonate k mol C/m3 
      Shco3= x[31];
      // Ammonia k mol N/m3 
      Snh3= x[32];

      //

      double[] substrate_network_digester= 
        science.math.getcol(substrate_network, myPlant.getDigesterIndex(digester_id) - 1);
    
      double[] ADM1params= myDigester.getADMparams(t, mySensors, 
                                      mySubstrates, substrate_network_digester);

      //
      // ADM1 parameter

      double fSI_XC, fCH_XC, fPR_XC, fLI_XC, fXP_XC, /*N_Xc*/fSIN_XC, N_I, N_aa, C_Xc, 
        C_SI, C_Xch, C_Xpr, C_Xli, C_XI, fFA_Xli, C_Sfa, fH2_SU, 
        fBU_SU, fPRO_SU, N_XB, C_Sbu, C_Spro, C_Sac, C_XB, Ysu, fH2_AA, 
        fVA_AA, fBU_AA, fPRO_AA, C_Sva, Yaa, fH2_FA, Yfa, fH2_VA, fPRO_VA, 
        fH2_BU, Yc4, fH2_PRO, Ypro, C_Sch4, Yac, Yh2, kdis, khyd_ch, khyd_pr, 
        khyd_li, KS_IN, km_su, KS_su, pHUL_a, pHLL_a, km_aa, KS_aa, km_fa, KS_fa, 
        KI_H2_fa, km_c4, KS_c4, KI_H2_c4, km_pro, KS_pro, KI_H2_pro, km_ac, 
                         KS_ac, KI_NH3, 
        pHUL_ac, pHLL_ac, km_h2, KS_h2, pHUL_h2, pHLL_h2, kdec_Xsu, kdec_Xaa, 
                         kdec_Xfa, kdec_Xc4, 
        kdec_Xpro, kdec_Xac, kdec_Xh2, Kw, Kava, Kabu, Kapro, Kaac, Kaco2, Kain, 
        kA_Bva, kA_Bbu, kA_Bpro, kA_Bac, kA_Bco2, kA_Bin, klaH2, klaCH4, 
                         klaCO2, KH_CO2, 
        KH_CH4, KH_H2, C_Xp, N_Xp, fP;

      // TODO : write static method getADMparameters as in ADM.cs
      // which returns each single parameter out of given ADM1params vector
      // using out, out, ...

      //[fSI_XC, fCH_XC, fPR_XC, fLI_XC, fXP_XC, N_Xc, N_I, N_aa, C_Xc, 
      //  C_SI, C_Xch, C_Xpr, C_Xli, C_XI, fFA_Xli, C_Sfa, fH2_SU, 
      //  fBU_SU, fPRO_SU, N_XB, C_Sbu, C_Spro, C_Sac, C_XB, Ysu, fH2_AA, 
      //  fVA_AA, fBU_AA, fPRO_AA, C_Sva, Yaa, fH2_FA, Yfa, fH2_VA, fPRO_VA, 
      //  fH2_BU, Yc4, fH2_PRO, Ypro, C_Sch4, Yac, Yh2, kdis, khyd_ch, khyd_pr, 
      //  khyd_li, KS_IN, km_su, KS_su, pHUL_a, pHLL_a, km_aa, KS_aa, km_fa, KS_fa, 
      //  KI_H2_fa, km_c4, KS_c4, KI_H2_c4, km_pro, KS_pro, KI_H2_pro, km_ac, 
      //                   KS_ac, KI_NH3, 
      //  pHUL_ac, pHLL_ac, km_h2, KS_h2, pHUL_h2, pHLL_h2, kdec_Xsu, kdec_Xaa, 
      //                   kdec_Xfa, kdec_Xc4, 
      //  kdec_Xpro, kdec_Xac, kdec_Xh2, Kw, Kava, Kabu, Kapro, Kaac, Kaco2, Kain, 
      //  kA_Bva, kA_Bbu, kA_Bpro, kA_Bac, kA_Bco2, kA_Bin, klaH2, klaCH4, 
      //                   klaCO2, KH_CO2, 
      //  KH_CH4, KH_H2, C_Xp, N_Xp, fP]= biogas.ADM.getADMparameters(ADM1params);

      //

      // eigentlich enthält XC kein SI, da XC über TS Gehalt bestimmt wird, welcher
      // kein soluble COD enthält. wenn aber aus XI im Fermenter teilweise SI entsteht
      // was nicht durch das ADM1 modelliert wird, dann wäre das als vereinfachung OK, ein
      // fSI_XC > 0 anzunehmen. bisher benötige ich das SI, da sonst der TS Gehalt
      // im fermenter und nachgärer zu hoch ist. alternative wäre die abbaurate zu erhöhen: 
      // D_VS

      fSI_XC= ADM1params[0];             	// fraction SI from XC

      fCH_XC= ADM1params[2];              // fraction Xch from XC
      fPR_XC= ADM1params[3];              // fraction Xpr from XC
      fLI_XC= ADM1params[4];              // fraction Xli from XC
      fXP_XC= ADM1params[5];              // fraction Xp from XC
      /*N_Xc*/fSIN_XC= ADM1params[6];    // TODO - austauschen mit fSIN_Xc
      N_I= ADM1params[7];
      N_aa= ADM1params[8];
      C_Xc= ADM1params[9];
      C_SI= ADM1params[10];
      C_Xch= ADM1params[11];
      C_Xpr= ADM1params[12];
      C_Xli= ADM1params[13];
      C_XI= ADM1params[14];


      fFA_Xli= ADM1params[17];
      C_Sfa= ADM1params[18];
      fH2_SU= ADM1params[19];
      fBU_SU= ADM1params[20];
      fPRO_SU= ADM1params[21];

      N_XB= ADM1params[23];
      C_Sbu= ADM1params[24];
      C_Spro= ADM1params[25];
      C_Sac= ADM1params[26];
      C_XB= ADM1params[27];
      Ysu= ADM1params[28];
      fH2_AA= ADM1params[29];
      fVA_AA= ADM1params[30];
      fBU_AA= ADM1params[31];
      fPRO_AA= ADM1params[32];

      C_Sva= ADM1params[34];
      Yaa= ADM1params[35];
      fH2_FA= ADM1params[36];
      Yfa= ADM1params[37];
      fH2_VA= ADM1params[38];
      fPRO_VA= ADM1params[39];
      fH2_BU= ADM1params[40];
      Yc4= ADM1params[41];
      fH2_PRO= ADM1params[42];
      Ypro= ADM1params[43];
      C_Sch4= ADM1params[44];
      Yac= ADM1params[45];
      Yh2= ADM1params[46];
      kdis= ADM1params[47];
      khyd_ch= ADM1params[48];
      khyd_pr= ADM1params[49];
      khyd_li= ADM1params[50];
      KS_IN= ADM1params[51];
      km_su= ADM1params[52];
      KS_su= ADM1params[53];
      pHUL_a= ADM1params[54];
      pHLL_a= ADM1params[55];
      km_aa= ADM1params[56];
      KS_aa= ADM1params[57];
      km_fa= ADM1params[58];
      KS_fa= ADM1params[59];
      KI_H2_fa= ADM1params[60];
      km_c4= ADM1params[61];
      KS_c4= ADM1params[62];
      KI_H2_c4= ADM1params[63];
      km_pro= ADM1params[64];
      KS_pro= ADM1params[65];
      KI_H2_pro= ADM1params[66];
      km_ac= ADM1params[67];
      KS_ac= ADM1params[68];
      KI_NH3= ADM1params[69];
      pHUL_ac= ADM1params[70];
      pHLL_ac= ADM1params[71];
      km_h2= ADM1params[72];
      KS_h2= ADM1params[73];
      pHUL_h2= ADM1params[74];
      pHLL_h2= ADM1params[75];
      kdec_Xsu= ADM1params[76];
      kdec_Xaa= ADM1params[77];
      kdec_Xfa= ADM1params[78];
      kdec_Xc4= ADM1params[79];
      kdec_Xpro= ADM1params[80];
      kdec_Xac= ADM1params[81];
      kdec_Xh2= ADM1params[82];
      Kw= ADM1params[83];
      Kava= ADM1params[84];
      Kabu= ADM1params[85];
      Kapro= ADM1params[86];
      Kaac= ADM1params[87];
      Kaco2= ADM1params[88];
      Kain= ADM1params[89];
      kA_Bva= ADM1params[90];
      kA_Bbu= ADM1params[91];
      kA_Bpro= ADM1params[92];
      kA_Bac= ADM1params[93];
      kA_Bco2= ADM1params[94];
      kA_Bin= ADM1params[95];
      klaH2= ADM1params[96];
      klaCH4= ADM1params[97];
      klaCO2= ADM1params[98];
      KH_CO2= ADM1params[99];
      KH_CH4= ADM1params[100];
      KH_H2= ADM1params[101];
      C_Xp= ADM1params[102];
      N_Xp= ADM1params[103];
      fP= ADM1params[104];

      //
      // variables

      // 1
      // fraction XI from XC
      double fXI_XC= 1 - fSI_XC - fCH_XC - fPR_XC - fLI_XC - fXP_XC;
      double fCO2_XC= C_Xc - fSI_XC*C_SI - fCH_XC*C_Xch - fPR_XC*C_Xpr - fLI_XC*C_Xli - 
                      fXI_XC*C_XI - fXP_XC*C_Xp;
      // NH3+NH4 fraction from XC
      // TODO - berechnung von N_xc aus fSIN_Xc, einfach gleichung umstellen
      //double fSIN_XC= N_Xc - fSI_XC*N_I - fPR_XC*N_aa - fXI_XC*N_I - fXP_XC*N_Xp;
      // TODO - wird gar nicht benötigt
      //double N_Xc = fSIN_XC + fSI_XC * N_I + fPR_XC * N_aa + fXI_XC * N_I + fXP_XC * N_Xp;

      //

      // TEST TODO
      // könnte sinn machen, da Snh4 und NH3 direkt über substratzufuhr in ADM1
      // rein gehen, damit ist XC stickstofffrei, alternativ muss N_Xc über Kalibrierung bestimmt 
      // werden -> ein Zusammenhang zwischen N und CSB
      // wie sieht es eigentlich mit gesamtstickstoff aus? bzw. mit TKN? hier werden nur NH3 und NH4
      // betrachtet, ok NO3 und NO2 brauch nicht, die komplettieren die stickstoff menge
      //fSIN_XC= 0; // ist 0, wird in getParams gesetzt


      //
      // Inorganic C fraction hydolysis Xli
      double fCO2_Xli= C_Xli - fFA_Xli * C_Sfa - ( 1 - fFA_Xli ) * C_Xch;
      double fAC_SU= 1 - fH2_SU - fBU_SU - fPRO_SU;
      double fCO2_SU= C_Xch-(fBU_SU*C_Sbu+fPRO_SU*C_Spro+fAC_SU*C_Sac)*(1-Ysu) - Ysu*C_XB;
      double fAC_AA= 1 - fH2_AA - fVA_AA - fBU_AA - fPRO_AA;
      double fCO2_AA= C_Xpr - (fVA_AA*C_Sva + fBU_AA*C_Sbu + fPRO_AA*C_Spro + 
                      fAC_AA*C_Sac)*(1 - Yaa) - Yaa*C_XB;
      double fAC_FA= 1.0 - fH2_FA;
      double fCO2_FA= C_Sfa-fAC_FA*C_Sac*(1-Yfa)-Yfa*C_XB;

      // 11
      double fAC_VA= 1 - fPRO_VA - fH2_VA;
      double fCO2_VA= C_Sva-(fPRO_VA*C_Spro + fAC_VA*C_Sac)*(1-Yc4) - Yc4*C_XB;
      double fAC_BU= 1 - fH2_BU;
      double fCO2_BU= C_Sbu-fAC_BU*C_Sac*(1-Yc4)-Yc4*C_XB;
      double fAC_PRO= 1 - fH2_PRO;
      double fCO2_PRO= C_Spro-fAC_PRO*C_Sac*(1-Ypro)-Ypro*C_XB;
      double fCO2_AC= C_Sac-(1-Yac)*C_Sch4-Yac*C_XB;
      // 1. Term: wg. stoichiometrie: h2+CO2 -> ch4
      // 2. Term: Aufnahme von kohlenstoff durch Bakterien
      double fCO2_H2= -1*(1-Yh2)*C_Sch4-Yh2*C_XB;

      //pfac_h= Scat + Snh4 - Shco3 - Sac_ / 64 - Spro_ / 112 - Sbu_ / 160 - Sva_
      // / 208 - San; 
      //SH= -1 * pfac_h/2 + 0.5 * ( pfac_h * pfac_h + 4*Kw )^0.5;

      // TODO
      // die angabe false sollte in abhängigkeit von usePhysValue gesetzt werden
      //try

      double SH, pfac_h;

      biogas.ADMstate.calcPHOfADMstate(x, Kw, out SH, out pfac_h);

      //catch ME
      //  disp(ME.message);
      //  disp('makeStoichiometry:biogas.ADMstate.calcPHOfADMstate');
      //  rethrow(ME);
      //end

      // 21
      // Iin ist inhibition bei Stickstoffmangel - ist bei landw. anlagen eher weniger der
      // fall, also ist Iin hier meistens 1 - 0.99
      double Iin= (Snh4+Snh3)/(Snh4+Snh3+KS_IN);
      // I_NH3 ist inhibition bei Vergiftung durch NH3
      // TODO: Problem ist, dass wenn man davon aus geht, dass Methanproduktion bei NH3 zw. 80 - 250 mg/l
      // inhibiert ist, dass die funktion I_NH3 in dem bereich nicht sehr sensitiv ist
      // bei 80 mg/l NH3 ca. 0.26 und bei 250 mg/l NH3 ca. 0.09. 
      // höchste sensitivität der funktion liegt zwischen 0 und 25 mg/l NH3 -> von 1 auf ca. 0.5
      // verhalten der funktion ändert sich auch nicht, wenn man KI_NH3 ändert, nur die abfallgeschwindigkeit
      // verändert sich
      double I_NH3= KI_NH3 / ( KI_NH3 + Snh3 );
      double I_H2_c4= KI_H2_c4/(KI_H2_c4 + Sh2);
      double KI_H_a= Math.Pow(10, -1* (pHUL_a+pHLL_a)/2);
      double IpH_a = KI_H_a * KI_H_a / (SH * SH + KI_H_a * KI_H_a);
      double KI_H_h2 = Math.Pow(10, -1 * (pHUL_h2 + pHLL_h2) / 2);
      double IpH_h2 = KI_H_h2 * KI_H_h2 * KI_H_h2 / 
                      (SH * SH * SH + KI_H_h2 * KI_H_h2 * KI_H_h2);
      // IpH_ac seems to inhibit only if pH below pHUL_ac, if above
      // pHLL_ac then no inhibition occurs. Default they are 6 and 7. 
      // source: ADM1 report, page: 27. There another function is used.
      // maybe this here is an approximation to the original function.
      // this is the simba implementation
      double KI_H_AC = Math.Pow(10, -1 * (pHUL_ac + pHLL_ac) / 2);
      double IpH_ac = KI_H_AC * KI_H_AC * KI_H_AC / 
                      (SH * SH * SH + KI_H_AC * KI_H_AC * KI_H_AC);
      // Fraction Xsu from biomass arising by decay
      double fCH_XB= fCH_XC/(fCH_XC+fPR_XC+fLI_XC)*(1-fP);

      // 31
      // Fraction Xpr from biomass arising by decay
      double fPR_XB= fPR_XC/(fCH_XC+fPR_XC+fLI_XC)*(1-fP);
      // Fraction Xli from biomass arising by decay
      double fLI_XB= fLI_XC/(fCH_XC+fPR_XC+fLI_XC)*(1-fP);
      double fSIN_XB= N_XB-fP*N_Xp-fPR_XB*N_aa;
      double fCO2_XB= C_XB-fP*C_Xp-fCH_XB*C_Xch-fPR_XB*C_Xpr-fLI_XB*C_Xli;

      //

      //// 
      // reaction rates p

      // Erweiterung der hydrolyse, abhängigkeit von TS gehalt im fermenter,
      // s. diss. von Koch 2010, S. 62

      // sollte man substratabhängig machen
      // deutlich höher weil jetzt mit Substrat TS gearbeitet wird und nicht mehr mit TS
      // von fermenter
      double Khyd = 2.5f;// 2.5f; // % FM s. S. 72 Diss. von Koch
      double nhyd = 2.3f; 

      // hole TS Gehalt in fermenter aus sensors
      // evtl. sollte man hier doch mit mittleren TS Gehalt der SUbstrate arbeiten?
      // ansonsten gibt es evtl. eine aufschaukelnde Wirkung des TS Gehaltes im Fermenter

      double TS_digester = 0.0f; // % FM

      try
      {
        // nehme TS des Fermenter Inputs und nicht TS im Fermenter, das wäre 3
        // macht leider große numerische Probleme!!! Konvergenz, damit wäre
        // übrigens auch Stoichiometry direkt von input abhängig, was sie bisher nicht
        // ist. (aus gutem grund wahrscheinlich)
//        mySensors.getCurrentMeasurementD("TS_" + digester_id + "_2", out TS_digester);
        mySensors.getCurrentMeasurementD("TS_" + digester_id + "_3", out TS_digester);

        // TODO - Abfrage > 40 ist nicht gut, ok jetzt
        if (TS_digester < double.Epsilon || TS_digester > 100)
          TS_digester = 11.0f;
      }
      catch
      {
        TS_digester = 11.0f;
      }

      double hydro_koch = 1.0f / (1.0f + Math.Pow(TS_digester / Khyd, nhyd));

      // TODO - test for VKL
      //hydro_koch = 1.0f;

      //if (hydro_koch < 0.001/*double.Epsilon*/ || hydro_koch > 1.0f)
      //  throw new exception(String.Format("hydro_koch: {0}", hydro_koch));

      //

      p= new double[25];

      // 36
      // Disintegration
      p[0]= kdis*Xc;
      // Hydrolysis carbohydrates
      p[1] = khyd_ch * Xch * hydro_koch;    // wie in Koch 2010
      // Hydrolysis of proteins
      p[2] = khyd_pr * Xpr * hydro_koch;    // wie in Koch 2010
      // Hydrolysis of Lipids
      p[3] = khyd_li * Xli * hydro_koch;    // wie in Koch 2010
      // Uptake of sugars
      p[4] = km_su * Ssu / (KS_su + Ssu) * Xsu * Iin * IpH_a;

      // 41
      // Uptake of amino acids
      p[5] = km_aa * Saa / (KS_aa + Saa) * Xaa * Iin * IpH_a;
      // Uptake of LCFA
      p[6] = km_fa * Sfa / (KS_fa + Sfa) * Xfa * Iin * KI_H2_fa / (KI_H2_fa + Sh2) * IpH_a;
      // Uptake of valerate
      p[7] = km_c4 * Sva / (KS_c4 + Sva) * Xc4 * Sva / (Sva + Sbu + 0.000001) * Iin * I_H2_c4 * IpH_a;
      // Uptake of Butyrate
      p[8] = km_c4 * Sbu / (KS_c4 + Sbu) * Xc4 * Sbu / (Sbu + Sva + 0.000001) * Iin * I_H2_c4 * IpH_a;
      // Uptake of propionate
      p[9] = km_pro * Spro / (KS_pro + Spro) * Xpro * Iin * KI_H2_pro / (KI_H2_pro + Sh2) * IpH_a;
      // Uptake of acetate
      p[10] = km_ac * Sac / (KS_ac + Sac) * Xac * Iin * I_NH3 * IpH_ac;
      // Uptake of hydrogen
      p[11] = km_h2 * Sh2 / (KS_h2 + Sh2) * Xh2 * Iin * IpH_h2;
      // decay of Xsu
      p[12] = kdec_Xsu * Xsu;
      // Decay of Xaa
      p[13] = kdec_Xaa * Xaa;
      // Decay of Xfa
      p[14] = kdec_Xfa * Xfa;

      // 51
      // Decay of Xc4
      p[15] = kdec_Xc4 * Xc4;
      // Decay of Xpro
      p[16] = kdec_Xpro * Xpro;
      // Decay of Xac
      p[17] = kdec_Xac * Xac;
      // Decay of Xh2
      p[18] = kdec_Xh2 * Xh2;
      // valerate acid-base
      p[19] = kA_Bva * (Sva_ * SH - Kava * (Sva - Sva_));
      // acid-base (butyrate)
      p[20] = kA_Bbu * (Sbu_ * SH - Kabu * (Sbu - Sbu_));
      // acid-base (propionate)
      p[21] = kA_Bpro * (Spro_ * SH - Kapro * (Spro - Spro_));
      // acid-base (acetate)
      // Sac ist ein Summenparameter definiert als Sac := Shac + Sac_
      // Shac ist demmnach die Säure und Sac_ die Base
      // hier steht demnach das selbe wie in der ADM1 Doku:
      // kA_Bac  * ( Sac_  * SH - Kaac  * Shac )
      p[22] = kA_Bac * (Sac_ * SH - Kaac * (Sac - Sac_));
      // 
      p[23] = kA_Bco2 * (Shco3 * SH - Kaco2 * Sco2);
      // acid-base (inorganic nitrogen)
      p[24] = kA_Bin * (Snh3 * SH - Kain * Snh4);

      //

      
      ////
      // stoichiometric matrix

      A= math.zeros(25, 33);

      // 

      // columns 0 - 3
      A[1,0]= 1;
                              A[2,1]= 1;
      A[3,0]= 1 - fFA_Xli;                    A[3,2]= fFA_Xli;
      A[4,0]= -1;     
                              A[5,1]= -1;                         A[5,3]= (1 - Yaa) * fVA_AA;
                                              A[6,2]= -1;         
                                                                  A[7,3]= -1;

      // columns 4 - 6
      A[4,4]= (1 - Ysu) * fBU_SU;     A[4,5]= (1 - Ysu) * fPRO_SU;        A[4,6]= (1 - Ysu) * fAC_SU;
      A[5,4]= (1 - Yaa) * fBU_AA;     A[5,5]= (1 - Yaa) * fPRO_AA;        A[5,6]= (1 - Yaa) * fAC_AA;
                                                                          A[6,6]= (1 - Yfa) * fAC_FA;
                                      A[7,5]= (1 - Yc4) * fPRO_VA;        A[7,6]= (1 - Yc4) * fAC_VA;
      A[8,4]= -1;                                                         A[8,6]= (1 - Yc4) * fAC_BU;
                                      A[9,5]= -1;                         A[9,6]= (1 - Ypro) * fAC_PRO;
                                                                          A[10,6]= -1;

      // columns 7 - 9
                                                              A[0,9]= fCO2_XC;


                                                              A[3,9]= fCO2_Xli;
      A[4,7]= (1 - Ysu) * fH2_SU;                             A[4,9]= fCO2_SU;
      A[5,7]= (1 - Yaa) * fH2_AA;                             A[5,9]= fCO2_AA;
      A[6,7]= (1 - Yfa) * fH2_FA;                             A[6,9]= fCO2_FA;
      A[7,7]= (1 - Yc4) * fH2_VA;                             A[7,9]= fCO2_VA;
      A[8,7]= (1 - Yc4) * fH2_BU;                             A[8,9]= fCO2_BU;
      A[9,7]= (1 - Ypro) * fH2_PRO;                           A[9,9]= fCO2_PRO;
                                      A[10,8]= 1 - Yac;       A[10,9]= fCO2_AC;
      A[11,7]= -1;                    A[11,8]= 1 - Yh2;       A[11,9]= fCO2_H2;
                                                              A= math.insertColumn(A, fCO2_XB, 12, 18, 9);
                                                              
                                                              A[23,9]= 1;

      // columns 10 - 13
      A[0,10]= fSIN_XC;               A[0,11]= fSI_XC;        A[0,12]= -1;    A[0,13]= fCH_XC;
                                                                              A[1,13]= -1;


      A[4,10]= -Ysu * N_XB;           
      A[5,10]= N_aa - Yaa * N_XB;
      A[6,10]= -Yfa * N_XB;
      A[7,10]= -Yc4 * N_XB;
      A[8,10]= -Yc4 * N_XB;
      A[9,10]= -Ypro * N_XB;
      A[10,10]= -Yac * N_XB;
      A[11,10]= -Yh2 * N_XB;
      A = math.insertColumn(A, fSIN_XB, 12, 18, 10);          A = math.insertColumn(A, fCH_XB, 12, 18, 13);

      A[24,10]= 1;

      // columns 14 - 17
      A[0,14]= fPR_XC;            A[0,15]= fLI_XC;        

      A[2,14]= -1;                
                                  A[3,15]= -1;
                                                          A[4,16]= Ysu;
                                                                                              A[5,17]= Yaa;
      A = math.insertColumn(A, fPR_XB, 12, 18, 14);
                                  A = math.insertColumn(A, fLI_XB, 12, 18, 15);
      A= math.insert(A, math.times(-1, math.eye(7,7)), 12, 16);

      // columns 18 - 23
                                                                                              A[0,23]= fXI_XC;
      A[6,18]= Yfa;
                      A[7,19]= Yc4;
                      A[8,19]= Yc4;
                             	      A[9,20]= Ypro;
                                                          A[10,21]= Yac;
                                                                              A[11,22]= Yh2;
                                                                              
      // columns 24 - 
      A[0,24]= fXP_XC;

      A = math.insertColumn(A, fP, 12, 18, 24);
      A= math.insert(A, math.times(-1, math.eye(6,6)), 19, 27);


                                                         
      //pgas_h2o= 0.0313 * exp( 5290 * ( 1 / 298 - 1 / T ) );


      // TODO - weiter machen

      // Partial pressure of Sh2 bar
      double piSh2= x[33];
      // Partial pressure of Sch4 bar 
      double piSch4= x[34];
      // Partial pressure of Sco2 bar
      double piSco2= x[35];
      // Sum of all partial pressures bar 
      double pTOTAL= x[36];

      // Gas law constant R [bar / ( M * K )]
      //R= 8.313999999999999 * 10^(-2);

      // Gas constant temperature [bar m^3/kmol]
      //RT= R*T;

      double Vgas= myDigester.get_param_of("Vgas");

      rho= new double[4];

      rho[0]= klaH2  * ( Sh2  - piSh2  * 16 / RT / KH_H2  ) * Vliq.Value / Vgas;
      rho[1]= klaCH4 * ( Sch4 - piSch4 * 64 / RT / KH_CH4 ) * Vliq.Value / Vgas;
      rho[2]= klaCO2 * ( Sco2 - piSco2 *  1 / RT / KH_CO2 ) * Vliq.Value / Vgas;
      rho[3]= kp * ( pTOTAL - pext ) * Vliq.Value / Vgas;

      G= math.zeros(4,4);

      // TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      // ich kann den ausdruck -Vgas/Vliq in Spalte 8 - 10 nicht finden!!!
      // 
      // kein Problem! Wird in calc_xdot berechnet, welches makeStoichiometry aufruft
      //
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


      //G= [RT/16,         0,              0,              RT/16;
      //    0,             RT/64,          0,              RT/64;
      //    0,             0,              RT,             RT;
      //    -piSh2/max(pTOTAL,eps), -piSch4/max(pTOTAL,eps), -piSco2/max(pTOTAL,eps), -1 ];

      G[0, 0]= RT/16;                                      G[0, 3]= RT/16;
                        G[1, 1]= RT/64;                    G[1, 3]= RT/64;
                                          G[2, 2]= RT;     G[2, 3]= RT;
      G[3, 0]= -piSh2/Math.Max(pTOTAL,double.Epsilon);
                        G[3, 1]= -piSch4/Math.Max(pTOTAL,double.Epsilon);
                                          G[3, 2]= -piSco2/Math.Max(pTOTAL,double.Epsilon);
                                                           G[3, 3]= -1;
      

      ////
      // Norm cubic meter [mol/m^3]
      //
      //NQ= 44.64300; // aus ADM1

      // total biogas flow [m^3/d]
      //Qgas= max( kp * ( pTOTAL - pext ) / ( RT / 1000 * NQ ) * Vliq, 0);

      //sum_pp= x(34,1) + x(35,1) + x(36,1);

      // calculate gas flow for each component
      //Qgas_h2= Qgas * x(34,1) / max(sum_pp, eps);
      //Qgas_ch4= Qgas * x(35,1) / max(sum_pp, eps);
      //Qgas_co2= Qgas * x(36,1) / max(sum_pp, eps);



      //intvars.adm1.(fermenter_id)= 
      double[] intvars_data0= 
               {Qgas_h2, Qgas_ch4, Qgas_co2, 
                fXI_XC, fCO2_XC, fSIN_XC, fCO2_Xli, fAC_SU, fCO2_SU, fAC_AA, 
                fCO2_AA, 
                fAC_FA, fCO2_FA, fAC_VA, fCO2_VA, fAC_BU, fCO2_BU, fAC_PRO, 
                fCO2_PRO, fCO2_AC, fCO2_H2, pfac_h, SH, Iin, I_NH3, I_H2_c4, 
                KI_H_a, IpH_a, KI_H_h2, IpH_h2, KI_H_AC, IpH_ac, fCH_XB, 
                fPR_XB, fLI_XB, fSIN_XB, fCO2_XB, Qgas};
            
      double[] intvars_data= new double[intvars_data0.Length + p.Length + rho.Length];

      intvars_data = math.insert(intvars_data, intvars_data0, 0);
      intvars_data = math.insert(intvars_data, p, intvars_data0.Length);
      intvars_data = math.insert(intvars_data, rho, intvars_data0.Length + p.Length);

      //List<double[]> myIntVars= new List<double[]>();

      //myIntVars.Add(intvars_data);
      //myIntVars.Add(p);
      //myIntVars.Add(rho);
      
      //double[] intvars_data= myIntVars.ToArray();


                                                    // Qgas set in mdlOutputs

      // try
      //     assigninMWS('intvars', intvars, 1);
      // catch ME
      //     rethrow(ME);
      // end

      // TODO
      //MWNumericArray mA= new MWNumericArray(4);// = (MWNumericArray)A;



      // if exist('plant_model', 'var') == 1
      // 
      //     plant_model.setintvars('ADM1', fermenter_id, intvars_data);
      //     
      // end

      //if exist('sensors', 'var') == 1
      // TODO deltatime is set to 0.01
     
      // TODO outcomment
      mySensors.measureVec(t, "ADMintvars_" + digester_id, intvars_data);
     

      // measure pH value
      // TODO
      mySensors.measure(t, "pH_" + digester_id + "_3", 
                        math.getrows(intvars_data, (int)BioGas.n_gases, intvars_data.Length - 1));

      //end

      mySensors.measure(t, "inhibition_" + digester_id, intvars_data);

      mySensors.measure(t, "aceto_hydro_" + digester_id, intvars_data, Yac, Yh2);

      //

    }


    
  }
}


