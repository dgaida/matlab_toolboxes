using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using biogas;
using science;
using biooptim;

namespace debugDLL
{
  class Program
  {
    static void Main(string[] args)
    {
      physValue COD= biogas.chemistry.calcTOC("Xch");

      //physValueBounded mol_mass= new physValueBounded("Sac");

      //double a= 1;

      //physValueBounded c= a* mol_mass;

      fitness_params myparams = new fitness_params("fitness_params_geiger.xml");

      myparams.set_params_of("manurebonus", true);

      //double[] state= new double[37];

      //physValueBounded fostac= biogas.ADMstate.calcFOSTACOfADMstate(state);

      //physValue C;
      //physValue H;

      //physValue Hh2= biogas.chemistry.Hh2;

      //biogas.chemistry.get_CHONS_of("Sac_", out C, out H);

      //physValue ThODch= biogas.chemistry.calcTheoreticalOxygenDemand("Xch");

      //biogas.substrate.createMe();

      //double[] a= biogas.ADMstate.getDefaultADMstate(33);

      //double[] b= biogas.ADMstate.getDefaultADMstate(33);

      //a[33]= 10;
      //b[33]= 15;

      //double[,] c= new double[a.Length, 2];

      //for (int ii= 0; ii < a.Length; ii++)
      //{
      //  c[ii, 0]= a[ii];
      //  c[ii, 1]= b[ii];
      //}

      //double[] d= biogas.ADMstate.mixADMstreams(c);

      //biogas.substrate mySubstrate= new biogas.substrate("manure_cattle_1.xml");

      //mySubstrate.print();

      //mySubstrate= new biogas.substrate("wheat_silage_3.xml");

      //mySubstrate.print();
      
      substrates mySubstrates= new biogas.substrates("substrate_geiger.xml");
      mySubstrates.print();
      //mySubstrates.saveAsXML("test.xml");

      plant myPlant= new biogas.plant("plant_geiger.xml");
      //myPlant.saveAsXML("test_plant.xml");

      //double[] Q= {1,2,3,4,5,6,7};
      
      //myPlant.myDigesters.get("main").AD_Model.getParams(Q, mySubstrates);

      digester myDigester = myPlant.myDigesters.get(1);

      myDigester.calcHeatLossDueToRadiation(new physValue(40, "°C"));

      double[] Q = { 15, 20, 0, 0, 0, 0, 0, 0, 0, 0 };
      double QdigesterIn = 35;

      double[] ADMparams= myDigester.AD_Model.getParams(0, Q, QdigesterIn, mySubstrates);

      //double[] x= biogas.ADMstate.getDefaultADMstate();

//      double[] x= { 0.00890042014469482,
//0.00393026902393572,
//0.0898975418574202,
//0.0105303688871217,
//0.0188083338344299,
//0.0891872294599488,
//4.06518710070508,
//1.48197701713060e-06,
//0.0463395911897687,
//0.0137825768581825,
//0.231507824368968,
//3.42633334388719,
//8.90655977614532,
//0.129429796425159,
//0.0457772931408461,
//0.0271093313710146,
//3.81638964565446,
//0.988123176978798,
//0.410214653254316,
//0.633820130695941,
//0.537171143510719,
//1.81695029971744,
//0.992459517922010,
//8.07171990003056,
//19.9716874568380,
//0.000997039324889569,
//0.0155655622013352,
//0.0104958374141159,
//0.0187566838733815,
//0.0889172491178123,
//4.05462904506225,
//0.152623707143880,
//0.00590111878589172,
//8.13313521280990e-05,
//0.465153466604388,
//0.506049932143382,
//0.971284730099898
////8.05130545875131e-05,
////0.460473427139200,
////0.500958421870263,
////0.961512362064050
// };

     double[] x= {  0.00719913836418267,
0.00322799288019040,
0.0546025712168657,
0.0115793536955362,
0.0229074890746752,
0.0600482037552511,
0.463364086785563,
7.72721521995682e-08,
0.0469910866922296,
0.0479055807768373,
0.154317294840363,
-1.35975859128971e-47,
21.5301936374036,
0.750446550594154,
0.161739337648583,
0.0603411370260300,
4.96860324952978,
0.832215069627251,
0.222662822346057,
0.629071151058018,
0.547835241984119,
2.00168204821595,
1.05831074978528,
29.5159593610614,
1.79228974953266,
1.27233772322647e-52,
1.77592375955463e-55,
0.0115411203828431,
0.0228383440861995,
0.0598411508360539,
0.462166407598810,
0.2406363011183078,
0.00374878408176311,
4.31650348109949e-06,
0.476514182736779,
0.487815404290303,
0.964333903530564};



      //biogas.sensors mySensors= 
      //  new biogas.sensors(new biogas.VFA_TAC_sensor("1"));

      //physValue VFA_TAC= mySensors.getCurrentMeasurement("VFA_TAC_1", 2);

      //VFA_TAC= mySensors.measure(0, "VFA_TAC_1", 1, x);

      //VFA_TAC= mySensors.measure(2, "VFA_TAC_1", 1, x);

      biogas.sensors mySensors= 
        new biogas.sensors(new biogas.TS_sensor("postdigester_3"));

      biogas.sensor_array mySensorArray= new biogas.sensor_array("Q");

      for (int isubstrate= 0; isubstrate < mySubstrates.getNumSubstrates(); isubstrate++)
        mySensorArray.addSensor( new biogas.Q_sensor(mySubstrates.getID(isubstrate + 1)) );

      mySensorArray.addSensor(new biogas.Q_sensor("postdigester_digester"));

      mySensors.addSensorArray(mySensorArray);

      mySensors.addSensor(new biogas.substrate_sensor("cost"));

      mySensors.addSensor(new biogas.pumpEnergy_sensor("postdigester_digester"));

      mySensors.addSensor(new biogas.total_biogas_sensor("", myPlant));

      //physValue VFA_TACs= mySensors.measure(0, "VS_1", 1, new double[]{1,2}, mySubstrates);

      double[,] substrate_network= { { 1, 0 }, { 1, 0 }, { 1, 0 }, { 1, 0 }, { 1, 0 }, { 1, 0 } };

      double[,] plant_network= { { 0, 1, 0 }, { 1, 0, 1 } };

      double TS;
      
      //mySensors.measure(0, "TS_digester_3", 1, x, 
      //          myPlant, mySubstrates, mySensors,
      //          substrate_network, plant_network, "digester", out TS);


      mySensors.measure(0, "substrate_cost", 0, mySubstrates, out TS);
      mySensors.measure(1, "substrate_cost", 0, mySubstrates, out TS);
      mySensors.measure(2, "substrate_cost", 0, mySubstrates, out TS);

      double energy;

      double[] pump = { 5 };

      mySensors.measure(0, "pumpEnergy_postdigester_digester", 0, myPlant, 10, pump, out energy);

      double[] data;

      mySensors.getMeasurementStream("substrate_cost", out data);

      double[] u= new double[6];
      u[0]= 10;
      u[1]= 100;
      u[2]= 100;
      u[3]= 20;
      u[4]= 200;
      u[5]= 200;

      mySensors.measureVec(0, "total_biogas_", 0, myPlant, u, "threshold", 5);

      physValue Qgas_h2;
      physValue Qgas_ch4;
      physValue Qgas_co2;

      physValue T= new physValue("T", 41.4, "°C");

      biogas.ADMstate.calcBiogasOfADMstate(x, new physValue(3000, "m^3"),
                                           T, out Qgas_h2, out Qgas_ch4, out Qgas_co2);

      double ph= biogas.ADMstate.calcPHOfADMstate(x);

      substrate mySubstrate = mySubstrates.get("swinemanure");

      biogas.ADMstate.calcADMstream(mySubstrate, 30);

      double mypH = mySubstrate.get_param_of("pH");

    }
  }
}
