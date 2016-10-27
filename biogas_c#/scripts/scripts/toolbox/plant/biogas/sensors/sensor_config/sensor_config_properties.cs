/**
 * This file is part of the partial class sensor_config and defines
 * the fields and properties of the class.
 * 
 * TODOs: 
 * - 
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using toolbox;
using System.Text;
using System.Collections;

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
  /// <remarks>
  /// special class for real measurements. defines how a physValue by a sensor is measured with noise
  /// drift, calibration, etc.
  /// </remarks>
  public partial class sensor_config
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// index in physValue array of sensor, this configuration is for:
    /// 0, 1, 2, ...
    /// </summary>
    private int index;

    /// <summary>
    /// if true, then add noise and drift to sensor values
    /// if false, then the directly measured sensor value is added to values
    /// this is the default
    /// </summary>
    private bool _apply_real_sensor = false;

    /// <summary>
    /// time constant of sensor (filter) [min]
    /// T in
    /// 1 / (1 + sT)^2
    /// kann man so konstant lassen, 
    /// Vorlage: Rieger, Alex: Progress in sensor technology, WST, 2003
    /// </summary>
    private double T_fil = 0.257;

    /// <summary>
    /// relative standard deviation of noise [-]
    /// kann man so konstant lassen
    /// 
    /// Vorlage: Rieger, Alex: Progress in sensor technology, WST, 2003
    /// </summary>
    private double noise_level = 0.025;

    /// <summary>
    /// minimum value [unit]
    /// </summary>
    private double y_min = 0;

    /// <summary>
    /// maximum value [unit]
    /// 
    /// immer ändern, von sensor zu sensor
    /// </summary>
    private double y_max = 100;

    /// <summary>
    /// drift [unit/d]
    /// 
    /// immer ändern, von sensor zu sensor
    /// </summary>
    private double drift = 0.5;

    /// <summary>
    /// integral of drift [unit] (nur intern)
    /// 
    /// zum start der simulation muss man integral zu 0 setzen
    /// is done in addMeasurement
    /// </summary>
    private double int_drift = 0;

    /// <summary>
    /// interval of calibration [d]
    /// 
    /// immer ändern, von sensor zu sensor
    /// </summary>
    private double dT_calib = 7;

    /// <summary>
    /// time for calibration [min]
    /// 
    /// immer ändern, von sensor zu sensor
    /// </summary>
    private double t_calib = 60;

    /// <summary>
    /// true, if currently sensor is calibrated, else false
    /// depends on t, dT_calib and t_calib
    /// (nur intern)
    /// </summary>
    private bool is_in_calib = false;

    /// <summary>
    /// integral of memory [unit] (nur intern)
    /// 
    /// zum start der simulation muss man integral zu 0 setzen
    /// is done in addMeasurement
    /// </summary>
    private double int_memory = 0;

    /// <summary>
    /// array with gaussian noise values (normal distribution, mean 0, std.dev. 1)
    /// </summary>
    private double[] noise_arr = { 0.3462,
    0.9943,
    1.6424,
   -0.4040,
   -2.4503,
   -0.8898,
    0.6707,
    0.3990,
    0.1273,
   -0.6859,
   -1.4992,
   -1.0621,
   -0.6251,
   -0.2370,
    0.1511,
    1.7690,
    2.3869,
    2.9824,
    2.5780,
    0.5183,
   -1.5414,
    0.6510,
    1.2434,
    1.6887,
    0.5339,
    0.1397,
   -0.2545,
    0.1344,
    0.5233,
    0.0634,
   -0.3965,
   -0.3560,
   -0.3156,
    0.4913,
    1.2982,
    1.2579,
    1.2175,
    1.2216,
    1.2257,
    0.8529,
    0.4800,
   -0.4595,
   -1.3990,
   -0.4366,
    0.5258,
    0.9823,
    1.4387,
    0.8681,
    0.2974,
    0.5703,
    0.8432,
    0.6893,
    0.5354,
    0.0202,
   -0.4949,
   -0.1963,
    0.1024,
   -0.4382,
   -0.9788,
   -0.1409,
    0.6969,
   -0.3208,
   -1.3386,
   -1.2995,
   -1.2604,
   -1.1307,
   -1.0010,
   -2.0684,
   -3.1358,
   -0.9444,
    1.2469,
    0.6903,
    0.1337,
   -0.4064,
   -0.9464,
    0.1162,
    1.1788,
   -0.3621,
   -1.9030,
   -1.0984,
   -0.2937,
   -0.3633,
   -0.4329,
   -0.1526,
    0.1277,
    0.1245,
    0.1214,
   -0.4675,
   -1.0564,
   -0.6390,
   -0.2215,
   -0.2890,
   -0.3564,
    0.0399,
    0.4362,
    0.6690,
    0.9018,
    0.9098,
    0.9178,
   -0.0687,
   -1.0551,
   -0.5846,
   -0.1141,
   -0.7599,
   -1.4056,
   -1.3553,
   -1.3050,
   -0.7517,
   -0.1983,
    0.5714,
    1.3411,
    0.1900,
   -0.9612,
   -0.3906,
    0.1799,
   -0.1186,
   -0.4171,
    0.2544,
    0.9259
 };

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// if true, then add noise and drift to sensor values
    /// if false, then the directly measured sensor value is added to values
    /// this is the default
    /// </summary>
    public bool apply_real_sensor
    {
      get { return _apply_real_sensor; }
    }
    


  }
}


