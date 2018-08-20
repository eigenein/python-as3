package org.osflash.signals
{
   public final class SlotList
   {
      
      public static const NIL:SlotList = new SlotList(null,null);
       
      
      public var head:ISlot;
      
      public var tail:SlotList;
      
      public var nonEmpty:Boolean = false;
      
      public function SlotList(param1:ISlot, param2:SlotList = null)
      {
         super();
         if(!param1 && !param2)
         {
            if(NIL)
            {
               throw new ArgumentError("Parameters head and tail are null. Use the NIL element instead.");
            }
            nonEmpty = false;
         }
         else
         {
            if(!param1)
            {
               throw new ArgumentError("Parameter head cannot be null.");
            }
            this.head = param1;
            this.tail = param2 || NIL;
            nonEmpty = true;
         }
      }
      
      public function get length() : uint
      {
         if(!nonEmpty)
         {
            return 0;
         }
         if(tail == NIL)
         {
            return 1;
         }
         var _loc1_:uint = 0;
         var _loc2_:* = this;
         while(_loc2_.nonEmpty)
         {
            _loc1_++;
            _loc2_ = _loc2_.tail;
         }
         return _loc1_;
      }
      
      public function prepend(param1:ISlot) : SlotList
      {
         return new SlotList(param1,this);
      }
      
      public function append(param1:ISlot) : SlotList
      {
         if(!param1)
         {
            return this;
         }
         if(!nonEmpty)
         {
            return new SlotList(param1);
         }
         if(tail == NIL)
         {
            return new SlotList(param1).prepend(head);
         }
         var _loc4_:SlotList = new SlotList(head);
         var _loc3_:* = _loc4_;
         var _loc2_:SlotList = tail;
         while(_loc2_.nonEmpty)
         {
            var _loc5_:* = new SlotList(_loc2_.head);
            _loc3_.tail = _loc5_;
            _loc3_ = _loc5_;
            _loc2_ = _loc2_.tail;
         }
         _loc3_.tail = new SlotList(param1);
         return _loc4_;
      }
      
      public function insertWithPriority(param1:ISlot) : SlotList
      {
         if(!nonEmpty)
         {
            return new SlotList(param1);
         }
         var _loc5_:int = param1.priority;
         if(_loc5_ > this.head.priority)
         {
            return prepend(param1);
         }
         var _loc4_:SlotList = new SlotList(head);
         var _loc3_:* = _loc4_;
         var _loc2_:SlotList = tail;
         while(_loc2_.nonEmpty)
         {
            if(_loc5_ > _loc2_.head.priority)
            {
               _loc3_.tail = _loc2_.prepend(param1);
               return _loc4_;
            }
            var _loc6_:* = new SlotList(_loc2_.head);
            _loc3_.tail = _loc6_;
            _loc3_ = _loc6_;
            _loc2_ = _loc2_.tail;
         }
         _loc3_.tail = new SlotList(param1);
         return _loc4_;
      }
      
      public function filterNot(param1:Function) : SlotList
      {
         if(!nonEmpty || param1 == null)
         {
            return this;
         }
         if(param1 == head.listener)
         {
            return tail;
         }
         var _loc4_:SlotList = new SlotList(head);
         var _loc3_:* = _loc4_;
         var _loc2_:SlotList = tail;
         while(_loc2_.nonEmpty)
         {
            if(_loc2_.head.listener == param1)
            {
               _loc3_.tail = _loc2_.tail;
               return _loc4_;
            }
            var _loc5_:* = new SlotList(_loc2_.head);
            _loc3_.tail = _loc5_;
            _loc3_ = _loc5_;
            _loc2_ = _loc2_.tail;
         }
         return this;
      }
      
      public function contains(param1:Function) : Boolean
      {
         if(!nonEmpty)
         {
            return false;
         }
         var _loc2_:* = this;
         while(_loc2_.nonEmpty)
         {
            if(_loc2_.head.listener == param1)
            {
               return true;
            }
            _loc2_ = _loc2_.tail;
         }
         return false;
      }
      
      public function find(param1:Function) : ISlot
      {
         if(!nonEmpty)
         {
            return null;
         }
         var _loc2_:* = this;
         while(_loc2_.nonEmpty)
         {
            if(_loc2_.head.listener == param1)
            {
               return _loc2_.head;
            }
            _loc2_ = _loc2_.tail;
         }
         return null;
      }
      
      public function toString() : String
      {
         var _loc2_:String = "";
         var _loc1_:* = this;
         while(_loc1_.nonEmpty)
         {
            _loc2_ = _loc2_ + (_loc1_.head + " -> ");
            _loc1_ = _loc1_.tail;
         }
         _loc2_ = _loc2_ + "NIL";
         return "[List " + _loc2_ + "]";
      }
   }
}
