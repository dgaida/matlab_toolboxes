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
* This file is part of the partial class substrate and contains
* the rest of the class, which is not located in seperate files.
* 
* TODOs:
* - try catchs fehlen in 2 methoden
* 
* Apart from that FINISHED!
* 
*/

using System;
using System.Collections.Generic;
using System.Text;
using science;
using toolbox;
using System.Xml;
using System.IO;
//using MathWorks.MATLAB.NET.Arrays;

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
  /// 
  /// TODOs: add all substrates out of database.m
  /// check if all references in substrate.m have been used
  /// </summary>
  public partial class substrate
  {

    // -------------------------------------------------------------------------------------
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// Creates a copy of the current object and returns the copy.
    /// </summary>
    /// <returns>identical copy of this</returns>
    public substrate copy()
    {
      return new substrate(this);
    }

    /// <summary>
    /// Sets substrate params read from a XML file, the passed
    /// reader object must already be at the beginning of the substrate declaration
    /// in the xml file, so either before &lt;substrate id= "..."> or directly after it.
    /// 
    /// If some parameters are not set, then somae parameters are calculated
    /// out of others. To them belong:
    /// COD, TS, NDF, ADF, N, C
    /// 
    /// TODO: try catchs fehlen
    /// </summary>
    /// <param name="reader">open reader</param>
    /// <returns>true on success, else false on error</returns>
    public bool getParamsFromXMLReader(ref XmlTextReader reader)
    {
      string xml_tag= "";
      string param= "";

      // these values could be inside the file as well
      physValue Cell=    new physValue(0, "% TS");
      physValue HemCell= new physValue(0, "% TS");
      physValue Ash=     new physValue(0, "% TS");
      
      // if this value is read out of file, then this value is true
      //bool setTS=      false;
      bool setVS=      false;
      bool setAsh=     false;
      //bool setCOD=     false;
      bool setCell=    false;
      bool setHemCell= false;
      bool setNDF=     false;
      bool setADF=     false;
      bool setCOD_S=   false;
      bool setSIin=    false;
      //bool setC=       false;
      //bool setN=       false;
      //bool set_c_th =  false;
      //bool set_rho =   false;

      // set params to default such that physValues are initialized at not null
      if (!set_params_to_default())
        return false;

      bool do_while= true;

      // go through the file
      while (reader.Read() && do_while)
      {
        switch (reader.NodeType)
        {

          case System.Xml.XmlNodeType.Element: // this knot is an element
            xml_tag= reader.Name;

            while (reader.MoveToNextAttribute())
            { // read the attributes, here only the attribute of digester
              // is of interest, all other attributes are ignored, 
              // actually there usally are no other attributes
              if (xml_tag == "physValue" && reader.Name == "symbol")
              {
                // found a new parameter
                param= reader.Value;

                switch (param)
                { 
                  case "RF":
                    Weender.RF.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "RP":
                    Weender.RP.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "RL":
                    Weender.RL.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "NDF":
                    setNDF= Weender.NDF.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "ADF":
                    setADF= Weender.ADF.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "ADL":
                    Weender.ADL.getParamsFromXMLReader(ref reader, param);
                    break;

                  case "Cell":
                    setCell= Cell.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "HemCell":
                    setHemCell= HemCell.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Ash":
                    setAsh= Ash.getParamsFromXMLReader(ref reader, param);
                    break;

                  //case "COD":
                  //  setCOD= Phys.COD.getParamsFromXMLReader(ref reader, param);
                  //  break;
                  case "COD_S":
                    setCOD_S= Phys.COD_S.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "SIin":
                    setSIin= Phys.SIin.getParamsFromXMLReader(ref reader, param);
                    break;
                  //case "c_th":
                  //  Phys.c_th.getParamsFromXMLReader(ref reader, param);
                  //  set_c_th = true;
                  //  break;
                  case "pH":
                    Phys.pH.getParamsFromXMLReader(ref reader, param);
                    break;
                  //case "rho":
                  //  Phys.rho.getParamsFromXMLReader(ref reader, param);
                  //  set_rho = true;
                  //  break;
                  case "Sac":
                    Phys.Sac.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Sbu":
                    Phys.Sbu.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Spro":
                    Phys.Spro.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Sva":
                    Phys.Sva.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "Snh4":
                    Phys.Snh4.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "TAC":   // TODO - should be renamed to TA
                    Phys.TAC.getParamsFromXMLReader(ref reader, param);
                    break;

                  case "T":
                    Phys.T.getParamsFromXMLReader(ref reader, param);
                    break;

                  //case "C":   // TODO - maybe delete  
                  //  setC= Phys.C.getParamsFromXMLReader(ref reader, param);
                  //  break;
                  //case "N":   // TODO - maybe delete
                  //  setN= Phys.N.getParamsFromXMLReader(ref reader, param);
                  //  break;

                  case "TS":
                    //setTS= 
                    Phys.TS.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "VS":
                    setVS= Phys.VS.getParamsFromXMLReader(ref reader, param);
                    break;

                  case "D_VS":
                    Phys.D_VS.getParamsFromXMLReader(ref reader, param);
                    break;

                  case "cost":
                    cost.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "age":
                    age.getParamsFromXMLReader(ref reader, param);
                    break;

                  case "kdis":
                    AD.kdis.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "khyd_ch":
                    AD.khyd_ch.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "khyd_pr":
                    AD.khyd_pr.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "khyd_li":
                    AD.khyd_li.getParamsFromXMLReader(ref reader, param);
                    break;

                  case "km_c4":
                    AD.km_c4.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "km_pro":
                    AD.km_pro.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "km_ac":
                    AD.km_ac.getParamsFromXMLReader(ref reader, param);
                    break;
                  case "km_h2":
                    AD.km_h2.getParamsFromXMLReader(ref reader, param);
                    break;
                }

                break;
              }
              else if (xml_tag == "substrate" && reader.Name == "id")
              {
                _id= reader.Value;

                break;
              }
            }
            break;

          case System.Xml.XmlNodeType.Text: // text, thus value, of each element

            switch (xml_tag)
            {
              case "name":
                _name= reader.Value;
                break;
              case "substrate_class":
                substrate_class= reader.Value;
                break;
            }

            break;

          case System.Xml.XmlNodeType.EndElement: // end of this substrate
            if (reader.Name == "substrate")
              do_while= false;      // end while loop

            break;
        }
      }

      // set calculatable values if they are not set

      //if (!setCOD)
      //  Phys.COD= calcXc().convertUnit("gCOD/l");

      //if (!setTS)
      //  Phys.TS= calcTS();

      if (!setNDF && setHemCell && setCell)
        Weender.NDF= calcNDF(HemCell, Cell, Weender.ADL);

      if (!setADF && setCell)
        Weender.ADF= calcADF(Cell, Weender.ADL);

      if (!setCOD_S)
      {
        // TODO - klappt die einheitenkonvertierung so? müsste
        Phys.COD_S =  Phys.Sva.convertUnit("gCOD/l") + 
                      Phys.Sbu.convertUnit("gCOD/l") + 
                      Phys.Spro.convertUnit("gCOD/l") + 
                      Phys.Sac.convertUnit("gCOD/l"); 
        Phys.COD_S.Symbol= "COD_S";

        // As COD is the total COD, this is wrong
        //Phys.COD=   ( 1 - 0.3 ) * Phys.COD;
        //Phys.COD.Symbol= "COD";
      }

      if (!setSIin)
      {
        Phys.SIin= calcSIin().convertUnit("gCOD/l");
      }

      if (!setVS && setAsh)
      {
        Phys.VS= calcVS(Phys.TS, Ash);
      }

      //if (!setC)      // TODO - maybe delete
      //  Phys.C= calcC();
      //else
      //  Phys.C= biogas.substrate.convertFrom_TS_To_FM(Phys.C, Phys.TS);

      //if (!setN)    // TODO - maybe delete
      //  Phys.N= calcN();
      //else
      //  Phys.N= biogas.substrate.convertFrom_TS_To_FM(Phys.N, Phys.TS);

      //if (!set_c_th)
      //  Phys.c_th = calcSpecificHeat();

      //if (!set_rho)
      //  Phys.rho = calcDensity();

      // These equations always hold
      // this is because of NfE is always calculated, as well as
      // NFC, HemCell and Cell

      // RF + NfE + RL + RP = VS
      // RP + RL + NFC + NDF = VS
      // RP + RL + NFC + HemCell + ADF = VS
      // RP + RL + NFC + HemCell + Cell + ADL = VS

      return true;
    }

    /// <summary>
    /// Returns substrate params as XML string, such that it can be saved 
    /// in a XML file
    /// </summary>
    /// <returns>string with xml tags</returns>
    public string getParamsAsXMLString()
    {
      StringBuilder sb= new StringBuilder();
            
      sb.Append(String.Format("<substrate id= \"{0}\">\n", id));

      sb.Append(xmlInterface.setXMLTag("name", name));

      // Weender
      sb.Append("<Weender>\n");
      sb.Append(Weender.RF.getParamsAsXMLString());
      sb.Append(Weender.RP.getParamsAsXMLString());
      sb.Append(Weender.RL.getParamsAsXMLString());
      sb.Append(Weender.NDF.getParamsAsXMLString());
      sb.Append(Weender.ADF.getParamsAsXMLString());
      sb.Append(Weender.ADL.getParamsAsXMLString());
      sb.Append("</Weender>\n");

      // Phys
      sb.Append("<Phys>\n");
      //sb.Append(Phys.COD.getParamsAsXMLString());
      sb.Append(Phys.COD_S.getParamsAsXMLString());
      sb.Append(Phys.SIin.getParamsAsXMLString());

      //sb.Append(Phys.c_th.getParamsAsXMLString());
      sb.Append(Phys.pH.getParamsAsXMLString());
      //sb.Append(Phys.rho.getParamsAsXMLString());

      sb.Append(Phys.Sac.getParamsAsXMLString());
      sb.Append(Phys.Sbu.getParamsAsXMLString());
      sb.Append(Phys.Spro.getParamsAsXMLString());
      sb.Append(Phys.Sva.getParamsAsXMLString());

      sb.Append(Phys.Snh4.getParamsAsXMLString());
      sb.Append(Phys.TAC.getParamsAsXMLString());

      sb.Append(Phys.T.getParamsAsXMLString());

      //sb.Append(Phys.C.getParamsAsXMLString());
      //sb.Append(Phys.N.getParamsAsXMLString());

      sb.Append(Phys.TS.getParamsAsXMLString());
      sb.Append(Phys.VS.getParamsAsXMLString());

      sb.Append(Phys.D_VS.getParamsAsXMLString());
      sb.Append("</Phys>\n");

      // AD
      sb.Append("<AD>\n");
      sb.Append(AD.kdis.getParamsAsXMLString());
      sb.Append(AD.khyd_ch.getParamsAsXMLString());
      sb.Append(AD.khyd_pr.getParamsAsXMLString());
      sb.Append(AD.khyd_li.getParamsAsXMLString());

      sb.Append(AD.km_c4.getParamsAsXMLString());
      sb.Append(AD.km_pro.getParamsAsXMLString());
      sb.Append(AD.km_ac.getParamsAsXMLString());
      sb.Append(AD.km_h2.getParamsAsXMLString());
      sb.Append("</AD>\n");

      //
      sb.Append(cost.getParamsAsXMLString());
      sb.Append(age.getParamsAsXMLString());

      sb.Append(xmlInterface.setXMLTag("substrate_class", substrate_class));
      
      //
      sb.Append("</substrate>\n");

      //

      return sb.ToString();
    }

    /// <summary>
    /// Saves the substrate in a xml file
    /// </summary>
    /// <param name="XMLfile">name of the xml file</param>
    public void saveAsXML(string XMLfile)
    {
      StreamWriter writer= File.CreateText(XMLfile);

      writer.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");

      writer.Write(getParamsAsXMLString());
      
      writer.Close();
    }

    // TODO - man könnte auch noch printMean(double[] Q) einführen, welches
    // parameter des gewichteten Substratgemisches printed

    /// <summary>
    /// Prints the substrate params to a string, such that the string
    /// can be written to a console.
    /// 
    /// For Custom Numeric Format Strings see:
    /// 
    /// http://msdn.microsoft.com/en-us/library/0c899ak8.aspx
    /// 
    /// TODO: try catch fehlen komplett
    /// 
    /// </summary>
    /// <returns>print to console</returns>
    public string print()
    {
      StringBuilder sb= new StringBuilder();

      sb.Append("   ----------   SUBSTRATE:   " + name + "   ----------   \r\n");
      sb.Append("id: " + id + "\r\n");

      // Weender
      sb.Append("Extended Weender Analysis: \n");
      sb.Append("  RF = " + Weender.RF.printValue()  + "\t\t\t");
      sb.Append("RP = "   + Weender.RP.printValue()  + "\t\t\t");
      sb.Append("RL = "   + Weender.RL.printValue()  + "\n");
      sb.Append("  NDF= " + Weender.NDF.printValue() + "\t\t\t");
      sb.Append("ADF= "   + Weender.ADF.printValue() + "\t\t\t");
      sb.Append("ADL= "   + Weender.ADL.printValue() + "\n");
      sb.Append("  NfE(c)= "   + get_params_of("NfE").printValue()     + "\t\t");
      sb.Append("NFC(c)= "     + get_params_of("NFC").printValue()     + "\n");
      sb.Append("  Cell(c)= "  + get_params_of("Cell").printValue()    + "\t\t");
      sb.Append("HemCell(c)= " + get_params_of("HemCell").printValue() + "\r\n");

      // Phys
      sb.Append("Physics: \n");
      //sb.Append("  COD= "    + Phys.COD.printValue()   + "\t\t");
      sb.Append("  COD_S= "    + Phys.COD_S.printValue() + "\t\t");
      sb.Append("SIin= " + Phys.SIin.printValue() + "\t\t");
      sb.Append("COD_SX(c)= " + calcCOD_SX().printValue() + "\n");

      sb.Append("  Xbac(c)= " + calcXbacteria().printValue() + "\t\t");
      sb.Append("Xmeth(c)= " + calcXmethan().printValue() + "\n");
      //sb.Append("aScod(c)= " + get_params_of("aScod").printValue(true) + "\n");

      //sb.Append("  c_th= " + Phys.c_th.printValue()   + "\t");
      //sb.Append("rho= "    + Phys.rho.printValue("0") + "\n");

      sb.Append("  c_th(c)= " + calcSpecificHeat().printValue() + "\t\t");
      sb.Append("T= " + Phys.T.printValue(true) + "\n");
      sb.Append("  pH= " + Phys.pH.printValue(true) + "\t\t");
      sb.Append("pH(c)= " + calc_pH().printValue(true) + "\t\t");
      sb.Append("rho(c)= " + calcDensity().printValue("0") + "\n");
      
      sb.Append("  Sac= " + Phys.Sac.printValue()  + "\t\t\t");
      sb.Append("Sbu= "    + Phys.Sbu.printValue()  + "\n");
      sb.Append("  Spro= " + Phys.Spro.printValue() + "\t\t\t");
      sb.Append("Sva= "    + Phys.Sva.printValue()  + "\t\t\t");
      // VFA
      sb.Append("Svfa(c)= " + calcVFA().printValue() + "\n");

      sb.Append("  Sac_= " + calcSac_().printValue() + "\t\t");
      sb.Append("Sbu_= " + calcSbu_().printValue() + "\t\t");
      sb.Append("Spro_= " + calcSpro_().printValue() + "\t\t");
      sb.Append("Sva_= " + calcSva_().printValue() + "\n");
      
      sb.Append("  Snh4= " + Phys.Snh4.printValue() + "\t\t\t");
      sb.Append("Snh3(c)= " + calcSnh3().convertUnit("g/l").printValue() + "\t\t\t");
      sb.Append("TKN(c, TS)= " + calcTKN().convertUnit("g/kg").printValue() + "\n");

      sb.Append("  TAC= " + Phys.TAC.printValue()    + "\t\t");
      sb.Append("Shco3= " + calcShco3().printValue() + "\t\t");
      sb.Append("Sco2= " + calcSco2().convertUnit("mol/m^3").printValue() + "\t\t");
      sb.Append("T= " + Phys.T.printValue("0.0") + "\n");

      sb.Append("  TS= "     + Phys.TS.printValue() + "\t\t");
      sb.Append("VS= "       + Phys.VS.printValue() + "\t\t");
      sb.Append("D_VS= "     + Phys.D_VS.printValue(true) + "\t\t");
      sb.Append("d= " + calc_d().ToString("0.00") + "\n");
      sb.Append("  Ash(c)= " + get_params_of("Ash").printValue() + "\t\t\t");
      sb.Append("Water(c)= " + get_params_of("Water").printValue() + "\r\n");

      sb.Append("  COD(c)= " + calcXc().printValue("0.0") + "\t");
      sb.Append("Xc,in(c)= " + calcXcIN().printValue("0.0") + "\t\t");
      //sb.Append("TS(c)= "    + calcTS().printValue("0.0") + "\t\t");
      sb.Append("TOC(c)= " + calcTOC().printValue("0.0") + "\r\n");

      sb.Append("  ThOD(c, FM)= " + calcTheoreticalOxygenDemand().printValue("0.0") + "\t\t");
      sb.Append("BMP(c, FM)= "    + calcBMP().printValue("0.0")  + "\t\t\t");
      sb.Append("gasQuality(c)= " + calcGasQuality().printValue("0.0") + "\r\n");
      sb.Append("  ch4_feed_ratio(c)= " + calcCH4tofeedCODratio().ToString("0.00") + "\r\n");

      sb.Append("  CO2(c, FM, bus)= " + calcCO2exp().printValue("0.0") + "\t\t");
      sb.Append("NH3(c, FM, bus)= " + calcNH3exp().convertUnit("ml/g").printValue("0.0") + "\t\t");
      sb.Append("H2S(c, FM, bus)= " + calcH2Sexp().convertUnit("ml/g").printValue("0.0") + "\r\n");
      
      sb.Append("  C(c, FM)= "     + calcC().printValue() + "\t\t\t");
      sb.Append("N(c, FM)= " + calcN().printValue() + "\t\t\t");
      sb.Append("C/N(c, FM)= " + calcCtoNratio().ToString("0.00") + "\n");
      sb.Append("  H(c, FM)= " + calcH().printValue() + "\t\t\t");
      sb.Append("O(c, FM)= " + calcO().printValue() + "\t\t\t");
      sb.Append("S(c, FM)= " + calcS().printValue() + "\n\r");
      
      sb.Append(String.Format("  CHONS= C_{0} H_{1} O_{2} N_{3} S_{4}\n\r", 
                get_C_of().Value.ToString("0.00"), get_H_of().Value.ToString("0.00"),
                get_O_of().Value.ToString("0.00"), get_N_of().Value.ToString("0.00"), 
                get_S_of().Value.ToString("0.00")));
      
      // f-Factors
      sb.Append("f-Factors: \n");
      sb.Append("  fCh_Xc(c)= " + get_param_of_d("fCh_Xc").ToString("0.000") + "\t\t\t");
      sb.Append("fPr_Xc(c)= " + get_param_of_d("fPr_Xc").ToString("0.000") + "\t\t");
      sb.Append("fLi_Xc(c)= " + get_param_of_d("fLi_Xc").ToString("0.000") + "\n");
      sb.Append("  fXI_Xc(c)= " + get_param_of_d("fXI_Xc").ToString("0.000") + "\t\t\t");
      sb.Append("fSI_Xc(c)= " + get_param_of_d("fSI_Xc").ToString("0.000") + "\t\t");
      sb.Append("fSIN_Xc(c)= " + get_param_of_d("fSIN_Xc").ToString("0.0000") + "\r\n");
      
      // AD
      sb.Append("Anaerobic Digestion Modelling Parameters: \n");
      sb.Append("  kdis= "    + AD.kdis.printValue()    + "\n");
      sb.Append("  khyd_ch= " + AD.khyd_ch.printValue() + "\t\t");
      sb.Append("khyd_pr= "   + AD.khyd_pr.printValue() + "\t\t");
      sb.Append("khyd_li= "   + AD.khyd_li.printValue() + "\r\n");

      sb.Append("  km_c4= " + AD.km_c4.printValue() + "\t\t");
      sb.Append("km_pro= " + AD.km_pro.printValue() + "\t\t");
      sb.Append("km_ac= " + AD.km_ac.printValue() + "\t\t");
      sb.Append("km_h2= " + AD.km_h2.printValue() + "\r\n");

      //
      sb.Append("cost= " + cost.printValue() + "\t\t");
      sb.Append("age= " + age.printValue() + "\n");

      sb.Append("substrate_class= " + substrate_class + "\r\n");

      //
      sb.Append("   ---------- ---------- ---------- ----------   \n");

      //

      return sb.ToString();
    }
       


  }
}


