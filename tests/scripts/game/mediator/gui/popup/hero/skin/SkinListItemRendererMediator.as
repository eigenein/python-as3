package game.mediator.gui.popup.hero.skin
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.hero.CommandHeroSkinUpgrade;
   import game.data.storage.DataStorage;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.skinunlock.SkinUnlockPopupMediator;
   import game.model.GameModel;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferEntry;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.textures.Texture;
   
   public class SkinListItemRendererMediator
   {
       
      
      public var skinVO:HeroPopupSkinValueObject;
      
      private var _signal_change:Signal;
      
      private var _signal_upgrade:Signal;
      
      public function SkinListItemRendererMediator()
      {
         _signal_change = new Signal();
         _signal_upgrade = new Signal();
         super();
         GameModel.instance.player.heroes.signal_heroChangeSkin.add(onChangeSkin);
         GameModel.instance.player.heroes.signal_heroUpgradeSkin.add(handler_upgradeSkin);
      }
      
      public function get signal_change() : Signal
      {
         return _signal_change;
      }
      
      public function get signal_upgrade() : Signal
      {
         return _signal_upgrade;
      }
      
      public function get upgradeCost() : InventoryItem
      {
         if(level < maxLevel && skinVO.skin.levels[level].cost)
         {
            return skinVO.skin.levels[level].cost.outputDisplayFirst;
         }
         return null;
      }
      
      public function getstatBonusByLevel(param1:uint) : BattleStatValueObject
      {
         if(param1 > 0 && param1 <= maxLevel)
         {
            return skinVO.skin.levels[param1 - 1].statBonus;
         }
         return null;
      }
      
      public function get eventTitle() : String
      {
         return DataStorage.specialOffer.getOfferNameById(eventID);
      }
      
      public function get localeKey() : String
      {
         return skinVO.skin.localeKey;
      }
      
      public function get level() : uint
      {
         return skinVO.hero.skinData.getSkinLevelByID(skinVO.skin.id);
      }
      
      public function get maxLevel() : uint
      {
         return skinVO.skin.levels.length;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getSkinTexture(skinVO.hero.hero,skinVO.skin);
      }
      
      public function get actionText() : String
      {
         if(level == 0 && isDefault)
         {
            return Translate.translate("UI_DIALOG_HERO_GUISE_UPGRADE");
         }
         if(level == 0)
         {
            return Translate.translate("UI_DIALOG_HERO_GUISE_UNLOCK");
         }
         if(level == maxLevel)
         {
            return Translate.translate("UI_DIALOG_HERO_USE_CONSUMABLE_LV_MAX");
         }
         return Translate.translate("UI_DIALOG_HERO_GUISE_UPGRADE");
      }
      
      public function get heroCurrentSkin() : uint
      {
         return skinVO.hero.currentSkin;
      }
      
      public function get isDefault() : Boolean
      {
         return skinVO.skin.isDefault;
      }
      
      public function get available() : Boolean
      {
         return skinVO.skin.enabled;
      }
      
      public function get skinID() : uint
      {
         return skinVO.skin.id;
      }
      
      public function get eventID() : int
      {
         return skinVO.skin.eventId;
      }
      
      public function get rendererVisible() : Boolean
      {
         if(level == 0 && eventID > 0)
         {
            if(available)
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      public function get specialOfferIsActive() : Boolean
      {
         return GameModel.instance.player.specialOffer.getSpecialOfferById(skinVO.skin.eventId) != null;
      }
      
      public function getSpecialOfferByID(param1:int) : PlayerSpecialOfferEntry
      {
         return GameModel.instance.player.specialOffer.getSpecialOfferById(param1);
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
         var _loc6_:* = skinVO.skin.levels;
         for each(var _loc4_ in skinVO.skin.levels)
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
         return _loc3_.name + " " + ColorUtils.hexToRGBFormat(15007564) + Translate.translateArgs("UI_DIALOG_FROM_TO",_loc3_.value,_loc2_.value);
      }
      
      public function get levelText() : String
      {
         return ColorUtils.hexToRGBFormat(16645626) + Translate.translate("UI_DIALOG_HERO_LEVEL_LABEL") + " " + level + "/" + maxLevel;
      }
      
      public function get tooltipText() : String
      {
         if(level < maxLevel)
         {
            return ColorUtils.hexToRGBFormat(16645626) + Translate.translate("UI_DIALOG_HERO_SKILL_NEXT_LEVEL") + "\n" + ColorUtils.hexToRGBFormat(16573879) + getSkinDescriptionByLevel(level + 1);
         }
         return null;
      }
      
      public function get billing() : PlayerBillingDescription
      {
         return GameModel.instance.player.billingData.getBySkinId(skinID);
      }
      
      public function skinUpgrade() : void
      {
         var _loc1_:CommandHeroSkinUpgrade = GameModel.instance.actionManager.hero.heroSkinUpgrade(skinVO.hero,skinVO.skin,false);
      }
      
      public function skinChange() : void
      {
         GameModel.instance.actionManager.hero.heroSkinChange(skinVO.hero,skinVO.skin,false);
      }
      
      public function navigateToObtain() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "hero";
         if(eventID && specialOfferIsActive)
         {
            Game.instance.navigator.navigateToSpecialOffer(eventID,_loc1_);
            return;
         }
         if(upgradeCost == null && level == 0)
         {
            Game.instance.navigator.navigateToShop(DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_GUILDWAR_SHOP),_loc1_);
         }
      }
      
      public function action_showSkinUnlockPopup() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "dialog_hero";
         new SkinUnlockPopupMediator(GameModel.instance.player,skinVO.hero,skinVO.skin).open(_loc1_);
      }
      
      private function handler_upgradeSkin(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean) : void
      {
         if(skinVO && param2 == skinVO.skin)
         {
            signal_upgrade.dispatch();
            if(level == 1 && skinVO.skin.isPremium)
            {
               skinChange();
            }
         }
      }
      
      private function onChangeSkin(param1:PlayerHeroEntry, param2:SkinDescription) : void
      {
         signal_change.dispatch();
      }
      
      public function dispose() : void
      {
         GameModel.instance.player.heroes.signal_heroChangeSkin.remove(onChangeSkin);
         GameModel.instance.player.heroes.signal_heroUpgradeSkin.remove(handler_upgradeSkin);
      }
   }
}
