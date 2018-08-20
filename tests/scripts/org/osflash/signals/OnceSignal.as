package org.osflash.signals
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class OnceSignal implements IOnceSignal
   {
       
      
      protected var _valueClasses:Array;
      
      protected var slots:SlotList;
      
      public function OnceSignal(... rest)
      {
         slots = SlotList.NIL;
         super();
         this.valueClasses = rest.length == 1 && rest[0] is Array?rest[0]:rest;
         SignalWatcher.registerSignal(this,String(rest));
      }
      
      public function get valueClasses() : Array
      {
         return _valueClasses;
      }
      
      public function set valueClasses(param1:Array) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get numListeners() : uint
      {
         return slots.length;
      }
      
      public function addOnce(param1:Function) : ISlot
      {
         return registerListener(param1,true);
      }
      
      public function remove(param1:Function) : ISlot
      {
         var _loc2_:ISlot = slots.find(param1);
         if(!_loc2_)
         {
            return null;
         }
         slots = slots.filterNot(param1);
         return _loc2_;
      }
      
      public function removeAll() : void
      {
         slots = SlotList.NIL;
      }
      
      public function dispatch(... rest) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = _valueClasses.length;
         var _loc2_:int = rest.length;
         if(_loc2_ < _loc5_)
         {
            throw new ArgumentError("Incorrect number of arguments. Expected at least " + _loc5_ + " but received " + _loc2_ + ".");
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(!(rest[_loc4_] is _valueClasses[_loc4_] || rest[_loc4_] === null))
            {
               throw new ArgumentError("Value object <" + rest[_loc4_] + "> is not an instance of <" + _valueClasses[_loc4_] + ">.");
            }
            _loc4_++;
         }
         var _loc3_:SlotList = slots;
         if(_loc3_.nonEmpty)
         {
            while(_loc3_.nonEmpty)
            {
               _loc3_.head.execute(rest);
               _loc3_ = _loc3_.tail;
            }
         }
      }
      
      protected function registerListener(param1:Function, param2:Boolean = false) : ISlot
      {
         var _loc3_:* = null;
         if(registrationPossible(param1,param2))
         {
            _loc3_ = new Slot(param1,this,param2);
            slots = slots.prepend(_loc3_);
            return _loc3_;
         }
         return slots.find(param1);
      }
      
      protected function registrationPossible(param1:Function, param2:Boolean) : Boolean
      {
         if(!slots.nonEmpty)
         {
            return true;
         }
         var _loc3_:ISlot = slots.find(param1);
         if(!_loc3_)
         {
            return true;
         }
         if(_loc3_.once != param2)
         {
            throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
         }
         return false;
      }
   }
}
