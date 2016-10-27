/**
 * This file defines funding via the EEG 2012.
 * 
 * TODOs:
 * - 
 * 
 * not yet finished
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
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
  /// <summary>
  /// funding structure of EEG 2012
  /// </summary>
  public class eeg2012 : funding
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// TODO: alt aus eeg 2009, gilt evtl. nicht für eeg 2012
    /// Grundvergütung in ct./kWh für eine Anlage Baujahr 2009
    /// el. Leistung: bis 150 kW, bis 500 kW, bis 5 MW, bis 20 MW
    /// </summary>
    private static double[] grundverguetung = { 11.67, 9.18, 8.25, 7.79 };

    

    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// 
    /// </summary>
    public eeg2012()
    {
      
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// 
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="Pel">electrical power in kW</param>
    /// <param name="var"></param>
    /// <returns></returns>
    override public double getVerguetung(biogas.plant myPlant, double Pel, bool var)
    {
      // TODO - write

      return 0;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="reader"></param>
    override public bool getParamsFromXMLReader(ref XmlTextReader reader)
    {
      // TODO - write

      return true;
    }

    /// <summary>
    /// get params as xml string
    /// </summary>
    /// <returns></returns>
    override public string getParamsAsXMLString()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("<EEG2012>\n");

      // TODO add 

      sb.Append("</EEG2012>\n");

      return sb.ToString();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    override public string print()
    {
      StringBuilder sb = new StringBuilder();

      sb.Append("   ----------   EEG 2012   ----------   \r\n");

      // TODO - add

      return sb.ToString();
    }



    /// <summary>
    /// Lets you set the different boni included in the EEG 2009
    /// </summary>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    public override void set_params_of(params object[] symbols)
    {
      for (int iarg = 0; iarg < symbols.Length; iarg = iarg + 2)
      {
        switch ((string)symbols[iarg])
        {
          
          default:
            throw new exception(String.Format("Unknown parameter: {0}!",
                                              (string)symbols[iarg]));
        }
      }
    }

    /// <summary>
    /// Get params as an array of objects.
    /// </summary>
    /// <param name="variables">values</param>
    /// <param name="symbols"></param>
    /// <exception cref="exception">Unknown parameter</exception>
    /// <exception cref="exception">No input argument</exception>
    public override void get_params_of(out object[] variables, params string[] symbols)
    {
      int nargin = symbols.Length;

      if (nargin > 0)
      {
        variables = new object[nargin];

        for (int iarg = 0; iarg < nargin; iarg++)
        {
          switch (symbols[iarg])
          {
            
            default:
              throw new exception(String.Format("Unknown parameter: {0}!", symbols[iarg]));
          }
        }
      }
      else
        throw new exception("You did not give an argument!");
    }


    
    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    

  }
}


