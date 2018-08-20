package game.mediator.gui.popup.mission
{
   import flash.utils.Dictionary;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import idv.cjcat.signals.Signal;
   
   public class MissionDropListProvider
   {
       
      
      private var player:Player;
      
      private var mission:MissionDescription;
      
      private var data:Vector.<MissionDropValueObject>;
      
      protected var signal_dataUpdated:Signal;
      
      public function MissionDropListProvider(param1:MissionDescription, param2:Player)
      {
         signal_dataUpdated = new Signal(Vector.<MissionDropValueObject>);
         super();
         this.player = param2;
         this.mission = param1;
         param2.specialOffer.signal_updated.add(handler_specialOfferUpdated);
         updateData();
      }
      
      public function dispose() : void
      {
         player.specialOffer.signal_updated.remove(handler_specialOfferUpdated);
         signal_dataUpdated.clear();
      }
      
      protected function get dataReady() : Boolean
      {
         return data;
      }
      
      public function whenDataUpdated(param1:Function) : void
      {
         if(dataReady)
         {
            param1(data);
         }
         signal_dataUpdated.add(param1);
      }
      
      public function remove(param1:Function) : void
      {
         signal_dataUpdated.remove(param1);
      }
      
      protected function updateData() : void
      {
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc3_:Dictionary = new Dictionary();
         var _loc5_:Vector.<MissionDropValueObject> = new Vector.<MissionDropValueObject>();
         var _loc7_:Vector.<InventoryItem> = mission.consolidatedDrop.outputDisplay;
         var _loc2_:int = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc1_ = _loc7_[_loc6_].item;
            if(!(_loc1_ is PseudoResourceDescription))
            {
               if(!(_loc1_ is ConsumableDescription))
               {
                  if(!_loc3_[_loc1_])
                  {
                     _loc3_[_loc1_] = true;
                     _loc4_ = new MissionDropValueObject(_loc7_[_loc6_],"endMission");
                     _loc5_.push(_loc4_);
                  }
               }
            }
            _loc6_++;
         }
         player.specialOffer.hooks.adjustMissionDrop(_loc5_);
         _loc5_.sort(_sortDropList);
         data = _loc5_;
      }
      
      private function _sortDropList(param1:MissionDropValueObject, param2:MissionDropValueObject) : int
      {
         return param2.sortPriority - param1.sortPriority;
      }
      
      private function handler_specialOfferUpdated() : void
      {
         updateData();
         signal_dataUpdated.dispatch(data);
      }
   }
}
