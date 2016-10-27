/**
 * This file is part of the partial class substrate and defines
 * the constructor methods of the class.
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
using System.Xml;
using System.IO;

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
  /// Defines the physicochemical characteristics of a substrate used on biogas plants.
  /// </summary>
  public partial class substrate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! CONSTRUCTOR METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Returns a copy of the template
    /// </summary>
    /// <param name="template">template</param>
    public substrate(substrate template)
    {
      _id= template.id;
      _name= template.name;

      Weender.RF=  template.Weender.RF.copy();
      Weender.RP=  template.Weender.RP.copy();
      Weender.RL=  template.Weender.RL.copy();
      Weender.NDF= template.Weender.NDF.copy();
      Weender.ADF= template.Weender.ADF.copy();
      Weender.ADL= template.Weender.ADL.copy();

      //Phys.COD=    template.Phys.COD.copy();
      Phys.COD_S=  template.Phys.COD_S.copy();
      //Phys.c_th=   template.Phys.c_th.copy();
      Phys.pH=     template.Phys.pH.copy();
      //Phys.rho=    template.Phys.rho.copy();
      Phys.Sac=    template.Phys.Sac.copy();
      Phys.Sbu=    template.Phys.Sbu.copy();
      Phys.Spro=   template.Phys.Spro.copy();
      Phys.Sva=    template.Phys.Sva.copy();
      Phys.Snh4=   template.Phys.Snh4.copy();
      Phys.TAC=    template.Phys.TAC.copy();
      //Phys.C=      template.Phys.C.copy();
      //Phys.N=      template.Phys.N.copy();
      Phys.T=      template.Phys.T.copy();
      Phys.TS=     template.Phys.TS.copy();
      Phys.VS=     template.Phys.VS.copy();
      Phys.D_VS=   template.Phys.D_VS.copy();

      AD.kdis=     template.AD.kdis.copy();
      AD.khyd_ch=  template.AD.khyd_ch.copy();
      AD.khyd_pr=  template.AD.khyd_pr.copy();
      AD.khyd_li=  template.AD.khyd_li.copy();
      
      AD.km_c4 =  template.AD.km_c4.copy();
      AD.km_pro = template.AD.km_pro.copy();
      AD.km_ac =  template.AD.km_ac.copy();
      AD.km_h2 =  template.AD.km_h2.copy();

      cost=        template.cost.copy();

      substrate_class= template.substrate_class;

    }

    /// <summary>
    /// Constructor called by the constructor of biogas.substrates while 
    /// reading substrates of a XML file. So reader must be at the correct position, 
    /// which is &lt;substrate id= "..."> was just read. That for the id of
    /// the substrate is given to this method.
    /// </summary>
    /// <param name="reader">an open reader</param>
    /// <param name="id">id of substrate</param>
    public substrate(ref XmlTextReader reader, string id)
    {
      _id= id;

      getParamsFromXMLReader(ref reader);
    }

    /// <summary>
    /// Constructor used to read substrate out of a XML file
    /// </summary>
    /// <param name="XMLfile">name of the xml file</param>
    public substrate(string XMLfile)
    {
      XmlTextReader reader= new System.Xml.XmlTextReader(XMLfile);

      getParamsFromXMLReader(ref reader);

      reader.Close();
    }

    /// <summary>
    /// creates an initialized substrate with default params
    /// </summary>
    /// <param name="id">id of substrate</param>
    /// <param name="name">name of substrate</param>
    public substrate(string id, string name)
    {
      this._id= id;
      this._name= name;

      set_params_to_default();
    }

    /// <summary>
    /// creates an initialized substrate with default params, 
    /// but with no name and no id
    /// </summary>
    /// <exception cref="exception">values.Length != 28</exception>
    public substrate() : this("", "")
    {}



  }
}


