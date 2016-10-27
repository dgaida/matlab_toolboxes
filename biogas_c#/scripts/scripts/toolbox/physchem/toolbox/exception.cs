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
 * Definition of an application exception class: ApplicationException.
 * 
 * TODOs:
 * - In class LogError which this class calls are a few TODOs
 * 
 * Apart from that FINISHED!
 * 
 */

using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;

/// <summary>
/// The toolbox namespace contains general classes used inside the toolbox.
/// </summary>
namespace toolbox
{
  /// <summary>
  /// class that can throw an user defined application exception: ApplicationException
  /// 
  /// contains a constructor, which accepts a string 
  /// 
  /// call as: throw new exception("error message") or
  /// throw new exception("error message", "myclass or myfile")
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
  public class exception : ApplicationException
  {
    /// <summary>
    /// standard constructor, calling base class
    /// </summary>
    public exception() : base()
    {
    }

    /// <summary>
    /// constructor which takes a string and passes
    /// it through to base class
    /// 
    /// furthermore prints and writes the stack trace in the file ErrorLog.txt
    /// by calling LogError.Log_Err
    /// </summary>
    /// <param name="message">string with the error message</param>
    public exception(string message) : this(message, "unknown class/file")
    {
    }

    /// <summary>
    /// constructor which takes a string and passes
    /// it through to the base class
    /// 
    /// furthermore prints and writes the stack trace in the file ErrorLog.txt
    /// by calling LogError.Log_Err
    /// </summary>
    /// <param name="message">string with the error message</param>
    /// <param name="source">source file or class where the error occured</param>
    public exception(string message, string source) : base(message)
    {

      // get call stack
      StackTrace stackTrace = new StackTrace();

      StringBuilder trace= new StringBuilder();

      trace.Append(source + ": ");    // add source class where error originally was thrown

      // get calling method name
      for (int ii = 0; ii < stackTrace.FrameCount; ii++)
      {
        // FileName und GetType bringen nichts, da nicht korrekt
        String methodfile= //stackTrace.GetFrame(ii).GetFileName() + ": " +
                //stackTrace.GetFrame(ii).GetType().ToString() + 
                //"." + 
                stackTrace.GetFrame(ii).GetMethod().Name;

        // 1st method is the method where error is thrown
        Console.WriteLine(methodfile);
        
        if (ii == stackTrace.FrameCount - 1)
          trace.Append(methodfile + ".");   // last one without a ,
        else
          trace.Append(methodfile + ", ");
      }

      try
      {
        // write trace of methods and error message in ErrorLog.txt file
        LogError.Log_Err(trace.ToString(), this);
      }
      catch
      { 
        // do not throw
      }
    }



  }
}


