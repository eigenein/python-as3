package game.mediator.gui.popup.skinunlock
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.social.BillingBuyCommandBase;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.skinunlock.SkinUnlockPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.textures.Texture;
   
   public class SkinUnlockPopupMediator extends PopupMediator
   {
       
      
      public var skin:SkinDescription;
      
      public var hero:PlayerHeroEntry;
      
      protected var _billing:BillingPopupValueObject;
      
      protected var _discountValue:int = 80;
      
      public function SkinUnlockPopupMediator(param1:Player, param2:PlayerHeroEntry, param3:SkinDescription)
      {
         super(param1);
         this.skin = param3;
         this.hero = param2;
         _billing = new BillingPopupValueObject(param1.billingData.getBySkinId(param3.id),param1);
      }
      
      public function get billing() : BillingPopupValueObject
      {
         return _billing;
      }
      
      public function get discountValue() : int
      {
         return _discountValue;
      }
      
      public function get oldPrice() : String
      {
         var _loc3_:String = billing.costString;
         var _loc2_:Array = _loc3_.split(" ");
         var _loc1_:Number = _loc2_[0];
         _loc1_ = _loc1_ * (100 / (100 - _discountValue));
         if(Math.round(_loc1_) != _loc1_)
         {
            return _loc1_.toFixed(2) + " " + _loc2_[1];
         }
         return _loc1_ + " " + _loc2_[1];
      }
      
      public function get billingRewardCoinItem() : InventoryItem
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < billing.reward.outputDisplay.length)
         {
            if(billing.reward.outputDisplay[_loc1_].item is CoinDescription)
            {
               return billing.reward.outputDisplay[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get billingRewardVIPPointsItem() : InventoryItem
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < billing.reward.outputDisplay.length)
         {
            if(billing.reward.outputDisplay[_loc1_].item is PseudoResourceDescription)
            {
               return billing.reward.outputDisplay[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getSkinTexture(hero.hero,skin);
      }
      
      public function get maxLevel() : uint
      {
         return skin.levels.length;
      }
      
      public function get level() : uint
      {
         return 0;
      }
      
      public function get upgradeCost() : CostData
      {
         if(level < maxLevel && skin.levels[level].cost)
         {
            return skin.levels[level].cost;
         }
         return null;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_int"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_str"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_agi"));
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SkinUnlockPopup(this);
         return _popup;
      }
      
      public function getSkinDescriptionByLevel(param1:uint) : String
      {
         var _loc5_:BattleStatValueObject = getstatBonusByLevel(param1);
         if(_loc5_)
         {
            return _loc5_.name + " " + ColorUtils.hexToRGBFormat(15007564) + "+" + _loc5_.value;
         }
         var _loc3_:BattleStatValueObject = null;
         var _loc2_:BattleStatValueObject = null;
         var _loc7_:int = 0;
         var _loc6_:* = skin.levels;
         for each(var _loc4_ in skin.levels)
         {
            if(_loc4_.statBonus)
            {
               if(!_loc2_ || _loc2_ && _loc4_.statBonus.statValue > _loc2_.statValue)
               {
                  _loc2_ = _loc4_.statBonus;
               }
               if(!_loc3_ || _loc3_ && _loc4_.statBonus.statValue < _loc3_.statValue)
               {
                  _loc3_ = _loc4_.statBonus;
               }
            }
         }
         return _loc3_.name + "\n" + ColorUtils.hexToRGBFormat(15007564) + Translate.translateArgs("UI_DIALOG_FROM_TO",_loc3_.value,_loc2_.value);
      }
      
      public function getstatBonusByLevel(param1:uint) : BattleStatValueObject
      {
         if(param1 > 0 && param1 <= maxLevel)
         {
            return skin.levels[param1 - 1].statBonus;
         }
         return null;
      }
      
      public function action_skinUpgrade() : void
      {
         Stash.click("skin_upgrade:" + skin.id,_popup.stashParams);
         var _loc1_:Boolean = player.canSpend(upgradeCost);
         GameModel.instance.actionManager.hero.heroSkinUpgrade(hero,skin,false);
         if(_loc1_)
         {
            close();
         }
         if(!hero.skinData.getSkinLevelByID(skin.id))
         {
         }
      }
      
      public function action_billing_buy() : void
      {
         Stash.click("skin_billing_buy:" + skin.id,_popup.stashParams);
         var _loc1_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(billing);
         _loc1_.signal_paymentBoxError.add(handler_paymentError);
         _loc1_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc1_.signal_paymentSuccess.add(handler_paymentSuccess);
      }
      
      protected function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentConfirm(param1:BillingBuyCommandBase) : void
      {
         if(!disposed && player)
         {
            close();
         }
      }
      
      protected function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
      }
   }
}
