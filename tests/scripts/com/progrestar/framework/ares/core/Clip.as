package com.progrestar.framework.ares.core
{
   import flash.geom.Rectangle;
   
   public class Clip extends Item
   {
       
      
      public var invertedResolution:Number = 1;
      
      public var timeLine:Vector.<IContent>;
      
      public var className:String;
      
      public var resource:ClipAsset;
      
      public var data:Object;
      
      public var marker:Boolean;
      
      public var linkSymbol:String;
      
      public var bounds:Rectangle;
      
      public function Clip(param1:uint)
      {
         timeLine = new Vector.<IContent>(0);
         super(param1);
      }
      
      public function copyFrom(param1:Clip) : void
      {
         invertedResolution = param1.invertedResolution;
         timeLine = param1.timeLine;
         className = param1.className;
         data = param1.data;
         marker = param1.marker;
         linkSymbol = param1.linkSymbol;
         bounds = param1.bounds;
      }
   }
}
