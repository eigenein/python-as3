package com.progrestar.framework.ares.core
{
   public class Container implements IContent
   {
       
      
      public var nodes:Vector.<Node>;
      
      public var firstFrameByNode:Vector.<uint> = null;
      
      public var id:uint;
      
      public function Container(param1:uint)
      {
         nodes = new Vector.<Node>(0);
         super();
         this.id = param1;
      }
   }
}
