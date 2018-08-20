package game.model.user.specialoffer
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   
   public class SpecialOfferViewEntryQueue
   {
       
      
      private var _sorted:Boolean = false;
      
      private var _firstElement:ObjectPropertyWriteable;
      
      private var _list:VectorPropertyWriteable;
      
      private var entries:Vector.<ViewSlotEntry>;
      
      public function SpecialOfferViewEntryQueue()
      {
         entries = new Vector.<ViewSlotEntry>();
         super();
      }
      
      public function get firstElement() : ObjectProperty
      {
         if(!_firstElement)
         {
            _firstElement = new ObjectPropertyWriteable(ViewSlotEntry,null);
         }
         if(!_sorted)
         {
            sort();
         }
         return _firstElement;
      }
      
      public function get list() : VectorProperty
      {
         if(!_list)
         {
            _list = new VectorPropertyWriteable(new Vector.<ViewSlotEntry>() as Vector.<*>);
         }
         if(!_sorted)
         {
            sort();
         }
         return _list;
      }
      
      public function unsubscribeFirst(param1:Function) : void
      {
         if(_firstElement)
         {
            _firstElement.unsubscribe(param1);
         }
      }
      
      public function unsubscribeList(param1:Function) : void
      {
         if(_list)
         {
            _list.unsubscribe(param1);
         }
      }
      
      public function add(param1:ViewSlotEntry) : void
      {
         if(param1 && entries.indexOf(param1) == -1)
         {
            entries.push(param1);
            param1.signal_removed.add(handler_entryRemoved);
            if(_firstElement || _list)
            {
               sort();
            }
            else
            {
               _sorted = false;
            }
         }
      }
      
      protected function sort() : void
      {
         entries.sort(ViewSlotEntry.sort_byPriority);
         if(_firstElement)
         {
            if(entries.length > 0)
            {
               _firstElement.value = entries[0];
            }
            else
            {
               _firstElement.value = ViewSlotEntry.NULL;
            }
         }
         if(_list)
         {
            _list.value = entries.concat() as Vector.<*>;
         }
         _sorted = true;
      }
      
      private function handler_entryRemoved(param1:ViewSlotEntry) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = entries.length;
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            var _loc6_:* = entries[_loc5_];
            entries[_loc5_ - _loc2_] = _loc6_;
            _loc3_ = _loc6_;
            if(_loc3_ == param1)
            {
               _loc3_.dispose();
               _loc2_++;
            }
            _loc5_++;
         }
         if(_loc2_ > 0)
         {
            entries.length = _loc4_ - _loc2_;
            if(_firstElement || _list)
            {
               sort();
            }
            else
            {
               _sorted = false;
            }
         }
      }
   }
}
