package game.model.user.specialoffer
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.inventory.InventoryItem;
   import game.util.StringUtils;
   
   public class InventoryItemSortOrder
   {
       
      
      private var order:Array;
      
      public function InventoryItemSortOrder(param1:Array)
      {
         super();
         this.order = param1;
      }
      
      public function sortReward(param1:RewardData) : Vector.<InventoryItem>
      {
         var _loc2_:Vector.<InventoryItem> = param1.outputDisplay;
         _loc2_.sort(sort);
         return _loc2_;
      }
      
      public function sort(param1:InventoryItem, param2:InventoryItem) : Number
      {
         return int(getSortingWeight(param1) - getSortingWeight(param2));
      }
      
      public function sortFastWithCopy(param1:Vector.<InventoryItem>) : Vector.<InventoryItem>
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         var _loc6_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc6_[_loc3_] = getSortingWeight(param1[_loc3_]);
            _loc3_++;
         }
         var _loc7_:Array = _loc6_.sort(8);
         var _loc2_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = _loc7_[_loc3_];
            _loc2_[_loc3_] = param1[_loc4_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getSortingWeight(param1:InventoryItem) : Number
      {
         var _loc2_:* = null;
         var _loc6_:InventoryItemType = param1.item.type;
         var _loc8_:String = _loc6_.type;
         var _loc4_:String = null;
         var _loc9_:* = _loc6_;
         if(InventoryItemType.PSEUDO !== _loc9_)
         {
            if(InventoryItemType.CONSUMABLE !== _loc9_)
            {
               if(InventoryItemType.COIN !== _loc9_)
               {
                  if(InventoryItemType.GEAR !== _loc9_)
                  {
                     if(InventoryItemType.SCROLL !== _loc9_)
                     {
                        if(InventoryItemType.HERO !== _loc9_)
                        {
                           if(InventoryItemType.TITAN !== _loc9_)
                           {
                              if(InventoryItemType.SKIN !== _loc9_)
                              {
                                 if(InventoryItemType.ARTIFACT !== _loc9_)
                                 {
                                 }
                              }
                              addr110:
                              _loc4_ = "fragment" + StringUtils.upperFirst(_loc8_);
                           }
                           addr109:
                           §§goto(addr110);
                        }
                        addr108:
                        §§goto(addr109);
                     }
                     addr107:
                     §§goto(addr108);
                  }
                  §§goto(addr107);
               }
               else
               {
                  _loc4_ = (param1.item as CoinDescription).ident;
               }
            }
            else
            {
               _loc4_ = (param1.item as ConsumableDescription).rewardType;
            }
         }
         else
         {
            _loc2_ = param1.item;
            if(_loc2_ == DataStorage.pseudo.STARMONEY)
            {
               _loc4_ = "starmoney";
            }
            else if(_loc2_ == DataStorage.pseudo.COIN)
            {
               _loc4_ = "gold";
            }
            else if(_loc2_ == DataStorage.pseudo.XP)
            {
               _loc4_ = "teamExp";
            }
            else if(_loc2_ == DataStorage.pseudo.STAMINA)
            {
               _loc4_ = "stamina";
            }
            else if(_loc2_ == DataStorage.pseudo.VIP)
            {
               _loc4_ = "vipPoints";
            }
            else if(_loc2_ == DataStorage.pseudo.CLAN_ACTIVITY)
            {
               _loc4_ = "clanActivity";
            }
            else if(_loc2_ == DataStorage.pseudo.DUNGEON_ACTIVITY)
            {
               _loc4_ = "dungeonActivity";
            }
         }
         var _loc5_:* = int(order.indexOf(_loc8_));
         var _loc3_:int = -1;
         var _loc7_:int = -1;
         if(_loc4_)
         {
            _loc3_ = order.indexOf(_loc4_);
            _loc7_ = order.indexOf(_loc4_ + param1.item.id);
         }
         if(_loc7_ == -1)
         {
            _loc7_ = order.indexOf(_loc8_ + param1.item.id);
         }
         if(_loc7_ != -1)
         {
            _loc5_ = _loc7_;
         }
         else if(_loc3_ != -1)
         {
            _loc5_ = _loc3_;
         }
         return _loc5_;
      }
   }
}
