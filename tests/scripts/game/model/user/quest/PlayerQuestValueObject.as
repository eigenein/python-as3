package game.model.user.quest
{
   import engine.core.utils.property.NumberProperty;
   import engine.core.utils.property.NumberPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.subscription.SubscriptionDescription;
   import game.model.user.inventory.InventoryItem;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class PlayerQuestValueObject
   {
       
      
      private const _removeAnimationProgress:NumberPropertyWriteable = new NumberPropertyWriteable(0);
      
      private var _entry:PlayerQuestEntry;
      
      private var _hasNavigator:Boolean;
      
      private var _rewards:Vector.<InventoryItem>;
      
      private var _mainRewardItemTexture:Texture;
      
      public function PlayerQuestValueObject(param1:PlayerQuestEntry, param2:Boolean)
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super();
         this._hasNavigator = param2;
         this._entry = param1;
         if(param1.reward.farmSubscription)
         {
            _loc5_ = DataStorage.subscription.getById(param1.reward.farmSubscription) as SubscriptionDescription;
            if(_loc5_)
            {
               this._rewards = _loc5_.dailyReward.outputDisplay;
            }
         }
         else if(param1.rewardSorting)
         {
            this._rewards = param1.rewardSorting.sortReward(param1.reward);
         }
         else
         {
            this._rewards = param1.reward.outputDisplay;
         }
         if(_rewards)
         {
            _loc3_ = _rewards.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(!(_rewards[_loc4_].item is PseudoResourceDescription))
               {
                  _mainRewardItemTexture = AssetStorage.inventory.getItemTexture(_rewards[_loc4_].item);
               }
               _loc4_++;
            }
            if(!_mainRewardItemTexture && _loc3_ > 0)
            {
               _mainRewardItemTexture = AssetStorage.inventory.getItemTexture(_rewards[0].item);
            }
            if(!_mainRewardItemTexture)
            {
               _mainRewardItemTexture = AssetStorage.rsx.popup_theme.missing_texture;
            }
         }
      }
      
      public function get removeAnimationProgress() : NumberProperty
      {
         return _removeAnimationProgress;
      }
      
      public function get entry() : PlayerQuestEntry
      {
         return _entry;
      }
      
      public function get hasNavigator() : Boolean
      {
         return _hasNavigator;
      }
      
      public function get signal_progressUpdate() : Signal
      {
         return _entry.signal_progressUpdate;
      }
      
      public function get mechanicLevel() : int
      {
         if(_entry.desc.farmCondition.stateFunc.mechanic)
         {
            return _entry.desc.farmCondition.stateFunc.mechanic.teamLevel;
         }
         return 0;
      }
      
      public function get id() : int
      {
         return entry.desc.id;
      }
      
      public function get progressCurrent() : int
      {
         return entry.progressCurrent < progressMax?entry.progressCurrent:int(progressMax);
      }
      
      public function get progressMax() : int
      {
         return entry.desc.farmCondition.amount;
      }
      
      public function get canFarm() : Boolean
      {
         return entry.canFarm;
      }
      
      public function get taskDescription() : String
      {
         return entry.desc.localeTaskDescription;
      }
      
      public function get rewards() : Vector.<InventoryItem>
      {
         return _rewards;
      }
      
      public function get debugTask() : String
      {
         var _loc1_:* = null;
         if(entry.desc.farmCondition.stateFunc)
         {
            _loc1_ = entry.desc.farmCondition.stateFunc.ident;
            _loc1_ = _loc1_ + (" " + JSON.stringify(entry.desc.farmCondition.functionArgs));
            return _loc1_;
         }
         return "-";
      }
      
      public function get questIconTexture() : Texture
      {
         var _loc1_:Texture = null;
         if(entry.desc.farmCondition.stateFunc.iconAssetTexture)
         {
            _loc1_ = AssetStorage.inventory.getQuestTexture(entry.desc.farmCondition.stateFunc.iconAssetTexture);
         }
         if(_loc1_)
         {
            return _loc1_;
         }
         if(_mainRewardItemTexture)
         {
            return _mainRewardItemTexture;
         }
         return AssetStorage.rsx.popup_theme.missing_texture;
      }
      
      public function get sortValue() : int
      {
         var _loc1_:int = 0;
         if(canFarm)
         {
            _loc1_ = _loc1_ + 10000;
         }
         if(hasNavigator)
         {
            _loc1_ = _loc1_ + 1000;
         }
         _loc1_ = _loc1_ + id;
         return _loc1_;
      }
   }
}
