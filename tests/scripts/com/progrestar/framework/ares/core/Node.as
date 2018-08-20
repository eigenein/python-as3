package com.progrestar.framework.ares.core
{
   public class Node extends Item
   {
       
      
      public var layer:uint;
      
      public var clip:Clip;
      
      public var state:State;
      
      public function Node(param1:uint)
      {
         super(param1);
      }
      
      public static function isEqual(param1:Node, param2:Node) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1.layer != param2.layer)
         {
            return false;
         }
         if(param1.clip != param2.clip)
         {
            return false;
         }
         if(param1.state != param2.state)
         {
            return false;
         }
         return true;
      }
      
      public function get x() : Number
      {
         return state.matrix.tx;
      }
      
      public function get y() : Number
      {
         return state.matrix.ty;
      }
   }
}
