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
 * Definition of an error logger.
 * 
 * TODOs:
 * - improve documentation
 * - a few TODOs below
 * 
 * Apart from that FINISHED!
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
    //                              !!! PUBLIC METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// method to call in the catch part of a try/catch block.
    /// 
    /// writes the error message given in Ex to a file. If file already exists
    /// then the error message is written at the end of the file.
    /// 
    /// Calls the private method LogErr.
    /// </summary>
    /// <param name="strErrorSource">method or file where the error was thrown</param>
    /// <param name="Ex">the error</param>
    /// <exception cref="NullReferenceException"></exception>
    /// <exception cref="IOException">Could not create folder given in strDirectoryPath</exception>
    public static void Log_Err(string strErrorSource, Exception Ex)
    {
      LogError errInfo = new LogError();

      errInfo.errorDt = System.DateTime.Now;
      errInfo.src = strErrorSource;
      errInfo.errorInfo = Ex;

      // can throw exceptions
      LogError.LogErr(errInfo);
    }



    // -------------------------------------------------------------------------------------
    //                              !!! PRIVATE METHODS !!!
    // -------------------------------------------------------------------------------------

    /// <summary>
    /// writes the error message given in errorDTO to a file called ErrorLog.txt. If file already 
    /// exists then the error message is written at the end of the file. If the property
    /// strDirectoryPath is not empty then the method tries to create the folder given
    /// in strDirectoryPath if not already existent.
    /// 
    /// TODO: die methode muss nicht public sein, private ist auch ok
    /// </summary>
    /// <param name="errorDTO">the LogError object</param>
    /// <exception cref="NullReferenceException"></exception>
    /// <exception cref="IOException">Could not create folder given in strDirectoryPath</exception>
    private static void LogErr(LogError errorDTO)
    {
      try
      {
        string directoryPath = strDirectoryPath; // path in which ErrorLog.txt file is created

        string path;    // path to file

        if (!string.IsNullOrEmpty(strDirectoryPath)) // at the moment it is empty
        {
          path = directoryPath + "\\" + "ErrorLog.txt";

          DirectoryInfo dtDirectory = null;

          // create directory if not yet existent
          if (!Directory.Exists(directoryPath))
          {
            try
            {
              dtDirectory = Directory.CreateDirectory(directoryPath);
            }
            catch (IOException)
            {
              // could not create folder
              throw; // re-throw the exception that the catch block caught.
            }

            dtDirectory = null;
          }
        }
        else
        {
          path = "ErrorLog.txt";
        }

        StreamWriter swErrorLog = null; // connection to file
        
        //if (File.Exists(path))
        //{
          swErrorLog = new StreamWriter(path, true); //append the error message
          swErrorLog.WriteLine("Date and Time of Exception: " + errorDTO.ErrorDate);
          swErrorLog.WriteLine("Source of Exception: " + errorDTO.ErrorSrc);
          swErrorLog.WriteLine(" ");
          swErrorLog.WriteLine("Error Message: " + errorDTO.ErrorInformation);
          swErrorLog.WriteLine("------------------------------------------- ");
          swErrorLog.WriteLine(" ");
          //swErrorLog.WriteLine(System.Security.Principal.WindowsIdentity.GetCurrent().Name);
          swErrorLog.Close();
          swErrorLog = null;
        //}
        //else
        //{
        //  //swErrorLog = File.CreateText(path); // wenn diese methode aufgerufen wird, dann führt nächste methode zu fehler
        //  swErrorLog = new StreamWriter(path, true); //append the error message
        //  swErrorLog.WriteLine("Date and Time of Exception: " + errorDTO.ErrorDate);
        //  swErrorLog.WriteLine("Source of Exception: " + errorDTO.ErrorSrc);
        //  swErrorLog.WriteLine(" ");
        //  swErrorLog.WriteLine("Error Message: " + errorDTO.ErrorInformation);
        //  swErrorLog.WriteLine("------------------------------------------- ");
        //  swErrorLog.WriteLine(" ");
        //  swErrorLog.Close();
        //  swErrorLog = null;
        //}
      }
      catch (NullReferenceException)
      {
        throw; // re-throw the exception that the catch block caught.
      }
    }
  }
}
