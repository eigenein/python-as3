package game.view.popup.chest
{
   import com.progrestar.common.util.collections.IIterator;
   import com.progrestar.common.util.collections.map.HashMap;
   import starling.display.DisplayObject;
   
   public class VirtualContainer
   {
       
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _alpha:Number = 1;
      
      private var _children:HashMap;
      
      public function VirtualContainer()
      {
         _children = new HashMap(DisplayObject,Params);
         super();
      }
      
      public function addChild(param1:DisplayObject) : void
      {
         if(!_children.contains(param1))
         {
            _children.put(param1,new Params(param1.x,param1.y,param1.alpha));
            param1.x = param1.x + _x;
            param1.y = param1.y + _y;
            param1.alpha = param1.alpha * _alpha;
         }
      }
      
      public function removeChild(param1:DisplayObject) : void
      {
         var _loc2_:* = null;
         if(_children.contains(param1))
         {
            _loc2_ = _children.get(param1);
            param1.x = _loc2_.x;
            param1.y = _loc2_.y;
            param1.alpha = param1.alpha;
         }
      }
      
      public function removeAll() : void
      {
         var _loc1_:IIterator = _children.keys;
         while(_loc1_.hasNext())
         {
            removeChild(_loc1_.getNext());
         }
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1 != _x)
         {
            _loc2_ = _children.keys;
            while(_loc2_.hasNext())
            {
               _loc4_ = _loc2_.getNext();
               _loc3_ = _children.get(_loc4_);
               _loc3_.x = _loc4_.x - _x;
               _loc4_.x = _loc3_.x + param1;
            }
            _x = param1;
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1 != _y)
         {
            _loc2_ = _children.keys;
            while(_loc2_.hasNext())
            {
               _loc4_ = _loc2_.getNext();
               _loc3_ = _children.get(_loc4_);
               _loc3_.y = _loc4_.y - _y;
               _loc4_.y = _loc3_.y + param1;
            }
            _y = param1;
         }
      }
      
      public function get alpha() : Number
      {
         return _alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         param1 = param1 > 1?1:Number(param1 < 0?0:Number(param1));
         if(param1 != _alpha)
         {
            _loc2_ = _children.keys;
            while(_loc2_.hasNext())
            {
               _loc4_ = _loc2_.getNext();
               _loc3_ = _children.get(_loc4_);
               _loc4_.alpha = _loc3_.alpha * param1;
            }
            _alpha = param1;
         }
      }
   }
}

class Params
{
    
   
   public var x:Number;
   
   public var y:Number;
   
   public var alpha:Number;
   
   function Params(param1:Number, param2:Number, param3:Number)
   {
      super();
      this.x = param1;
      this.y = param2;
      this.alpha = param3;
   }
}
