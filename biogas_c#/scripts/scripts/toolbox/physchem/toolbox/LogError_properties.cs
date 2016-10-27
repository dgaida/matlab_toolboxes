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
 * Definition of the properties and private fields of an error logger.
 * 
 * TODOs:
 * - improve documentation
 * - a few TODOs below
 * 
 * Not FINISHED!
 * 
 * source:
 * http://www.daniweb.com/software-development/csharp/threads/363340/how-to-capture-error-log-using-c.net
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

/// <summary>
/// The toolbox namespace contains general classes used inside the toolbox.
/// </summary>
namespace toolbox
{
  /// <summary>
  /// logs errors to a file called ErrorLog.txt.
  /// file is created in directory strDirectoryPath. If file already exists then
  /// the message is written at the end of the file.
  /// 
  /// You should call the static method LogError.Log_Err in the catch part of
  /// a try/catch block. 
  /// 
  /// Look also at the class exception which calls the method LogError.Log_Err
  /// 
  /// writes messages such as:
  /// 
  /// Date and Time of Exception: 02.11.2014 21:00:01
  /// Source of Exception: .ctor, getByName, getByName, InvokeMethod, UnsafeInvokeInternal, Invoke, dotnetcli.NETMethod.invoke, 
  /// 
  /// Error Message: toolbox.exception: Cannot find the substrate (name: test) in the list!
  /// ------------------------------------------- 
  /// 
  /// </summary>
  public partial class LogError
  {

    // -------------------------------------------------------------------------------------
    //                            !!! PRIVATE FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// saves the date and time when the error was thrown. More precisely when
    /// the method Log_Err was called. 
    /// </summary>
    private DateTime errorDt;

    /// <summary>
    /// source file or method throwing the error
    /// </summary>
    private string src;

    /// <summary>
    /// the exception object containing the error
    /// </summary>
    private Exception errorInfo;



    // -------------------------------------------------------------------------------------
    //                            !!! PUBLIC FIELDS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// directory in which the file is saved
    /// darf auch leer sein, dann wird in aktuellen Ordner geschrieben
    /// da wo die exe liegt
    /// 
    /// TODO - entweder gar nicht setzen, oder die Wahl geben
    /// zu dem Pfad, funktioniert sonst nicht, wenn man die toolbox
    /// raus gibt
    /// TODO - muss die public sein?
    /// </summary>
    private static string strDirectoryPath;//= "D:";



    // -------------------------------------------------------------------------------------
    //                              !!! PROPERTIES !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// saves the date and time when the error was thrown. More precisely when
    /// the method Log_Err was called. 
    /// </summary>
    public DateTime ErrorDate
    {
      get {return errorDt; }
      // TODO - finde ich nicht gut, dass die public ist
      //set { errorDt = value;}
    }

    /// <summary>
    /// source file or method throwing the error
    /// </summary>
    public string ErrorSrc
    {
      get { return src; }
      // TODO - finde ich nicht gut, dass die public ist
      //set { src = value; }
    }

    /// <summary>
    /// the exception object containing the error
    /// </summary>
    public Exception ErrorInformation
    {
      get { return errorInfo; }
      // TODO - finde ich nicht gut, dass die public ist
      //set { errorInfo = value; }
    }

  }
}
