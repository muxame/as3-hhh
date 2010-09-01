/**
* ...
* @author Dennis Jaamann
* @version 1.0
* Util Class that converts units from one given unit to another
* 
* 
Copyright (c) 2009 Dennis Jaamann

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package com.dj.util
{
	public class UnitConverter
	{
		/**
		 * Length
		 */
		public static function kilometersToMiles(kilometers:Number):Number{
			return kilometers * 0.621371192;
		}
		
		public static function kilometersToNauticalMiles(kilometers:Number):Number{
			return kilometers * 0.539956803;
		}
		
		public static function milesToKilometers(miles:Number):Number{
			return miles * 1.609344;
		}
		
		public static function milesToNauticalMiles(miles:Number):Number{
			return miles * 0.868976242; 
		}
		
		public static function nauticalMilesToKilometers(nauticalMiles:Number):Number{
			return nauticalMiles * 1.85200;
		}
		
		public static function nauticalMilesToMiles(nauticalMiles:Number):Number{
			return nauticalMiles * 1.15077945;
		}
		
		public static function metersToFeet(meters:Number):Number{
			return meters * 3.2808399;
		}
		
		public static function feetToMeters(feet:Number):Number{
			return feet * 0.3048;
		}
		
		public static function metersToYards(meters:Number):Number{
			return meters * 1.0936133;
		}
		
		public static function yardsToMeters(yards:Number):Number{
			return yards * 0.9144;
		}
		
		public static function centimetersToInches(centimeters:Number):Number{
			return centimeters * 0.393700787;
		}
		
		public static function inchesToCentimeters(inches:Number):Number{
			return inches * 2.54;
		}
		
		/**
		 * Temperature
		 */  
		public static function fahrenheitToCelsius(degrees:Number):Number{
			return (degrees - 32) / 1.8;			
		}
		
		public static function fahrenheitToKelvin(degrees:Number):Number{
			return (degrees + 459.67) / 1.8;
		}
		
		public static function celsiusToFahrenheit(degrees:Number):Number{
			return (degrees * 1.8) + 32;
		}
		
		public static function celsiusToKelvin(degrees:Number):Number{
			return degrees + 273.15;
		}
		
		public static function kelvinToCelsius(degrees:Number):Number{
			return degrees - 273.15;
		}
		
		public static function kelvinToFahrenheit(degrees:Number):Number{
			return (degrees * 1.8) - 459.67;
		}
		
		/**
		 * Weight
		 */ 
		public static function kilogramsToPounds(kilograms:Number):Number{
			return kilograms * 2.20462262;
		}
		
		public static function kilogramsToStone(kilograms:Number):Number{
			return kilograms * 0.157473044;
		}
		
		public static function poundsToKilograms(pounds:Number):Number{
			return pounds * 0.45359237;
		}
		
		public static function poundsToStone(pounds:Number):Number{
			return pounds * 0.0714285714;
		}
		
		public static function stoneToPounds(stone:Number):Number{
			return stone * 14;
		}
		
		public static function stoneToKilograms(stone:Number):Number{
			return stone * 6.35029318;
		}
		
		public static function gramsToOunces(grams:Number):Number{
			return grams * 0.0352739619;
		}
		
		public static function ouncesToGrams(ounces:Number):Number{
			return ounces * 28.3495231;
		}
		
		/**
		 * Speed
		 */
		public static function kilometersPerHourToKnots(kilometersPerHour:Number):Number{
			return kilometersPerHour * 0.539956803; 
		}
		
		public static function kilometersPerHourToMilesPerHour(kilometersPerHour:Number):Number{
			return kilometersPerHour * 0.621371192;
		}
		
		public static function milesPerHourToKnots(milesPerHour:Number):Number{
			return milesPerHour * 0.868976242; 
		}
		
		public static function milesPerHourToKilometersPerHour(milesPerHour:Number):Number{
			return milesPerHour * 1.609344;
		} 
		
		public static function knotsToKilometersPerHour(knots:Number):Number{
			return knots * 1.85200;
		}
		
		public static function knotsToMilesPerHour(knots:Number):Number{
			return knots * 1.15077945;
		}

		/**
		 * Volume
		 */ 
		public static function litersToGallons(liters:Number):Number{
			return liters * 0.264172052;
		}
		
		public static function gallonsToLiters(gallons:Number):Number{
			return gallons * 3.78541178;
		}
		
		public static function cubicFeetToCubicMeters(cubicFeet:Number):Number{
			return cubicFeet * 0.0283168466;
		}
		
		public static function cubicMetersToCubicFeet(cubicMeters:Number):Number{
			return cubicMeters * 35.3146667;
		}
				
		/**
		 * Power
		 */
		 public static function kilowattsToHorsepower(kilowatts:Number):Number{
		 	return kilowatts * 1.34102209;
		 }
		 
		 public static function horsepowerToKilowatts(horsepower:Number):Number{
		 	return horsepower * 0.745699872;
		 } 
	}
}