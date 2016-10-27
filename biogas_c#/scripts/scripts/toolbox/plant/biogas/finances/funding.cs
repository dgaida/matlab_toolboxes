/**
 * This file defines funding via the EEG 2009.
 * 
 * TODOs:
 * - improve documentation
 * 
 * Except for that looks pretty good!
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
  /// funding of biogas plant by Erneuerbare Energien Gesetz
  /// </summary>
  abstract public class funding : set_get_interface
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------



    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Calculate renumeration in €/kWh
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="Pel">electrical power in kW</param>
    /// <param name="var"></param>
    /// <returns>renumeration in €/kWh</returns>
    abstract public double getVerguetung(biogas.plant myPlant, double Pel, bool var);

    /// <summary>
    /// Calculate renumeration in €/kWh
    /// TODO: evtl. für EEG 2012 nutzen
    /// </summary>
    /// <param name="myPlant"></param>
    /// <param name="mySubstrates"></param>
    /// <param name="Pel">electrical power in kW</param>
    /// <param name="var"></param>
    /// <returns>renumeration in €/kWh</returns>
    virtual public double getVerguetung(biogas.plant myPlant, biogas.substrates mySubstrates, 
      double Pel, bool var)
    {
      throw new exception("Not implemented!");
    }

    /// <summary>
    /// read params using the given XML reader, which is reading a xml file
    /// </summary>
    /// <param name="reader">an open reader</param>
    /// <returns>true on success, else false</returns>
    abstract public bool getParamsFromXMLReader(ref XmlTextReader reader);

    /// <summary>
    /// get params as xml string
    /// </summary>
    /// <returns></returns>
    abstract public string getParamsAsXMLString();

    /// <summary>
    /// print to console
    /// </summary>
    /// <returns></returns>
    abstract public string print();



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------



  }
}
