package game.mediator.gui.popup.chest
{
   import com.progrestar.common.util.CollectionUtil;
   import game.command.rpc.chest.CommandChestBuy;
   import game.data.storage.DataStorage;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.chest.TownChestFullscreenPopup;
   import game.view.popup.chestrewardheroeslist.ChestRewardHeroesListPopUpMediator;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   
   public class ChestPopupMediator extends PopupMediator
   {
      
      public static const PROMO_QUEST_ID:int = 245;
       
      
      private var _townChest:ChestPopupValueObject;
      
      private var _questPromo:PlayerQuestValueObject;
      
      private var _signal_questPromoUpdate:Signal;
      
      public function ChestPopupMediator(param1:Player)
      {
         _signal_questPromoUpdate = new Signal();
         super(param1);
         createHeroListPresentation();
         param1.questData.signal_questAdded.add(handler_promoQuestUpdated);
         param1.questData.signal_questRemoved.add(handler_promoQuestUpdated);
         param1.questData.signal_questProgress.add(handler_promoQuestUpdated);
      }
      
      override protected function dispose() : void
      {
         _townChest.dispose();
         player.questData.signal_questAdded.remove(handler_promoQuestUpdated);
         player.questData.signal_questRemoved.remove(handler_promoQuestUpdated);
         player.questData.signal_questProgress.remove(handler_promoQuestUpdated);
         super.dispose();
      }
      
      public function get townChest() : ChestPopupValueObject
      {
         return _townChest;
      }
      
      public function get questPromo() : PlayerQuestValueObject
      {
         var _loc1_:PlayerQuestEntry = player.questData.getQuest(245);
         if(_loc1_ && !_loc1_.canFarm)
         {
            return new PlayerQuestValueObject(_loc1_,false);
         }
         return null;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      public function get playerHasSuperHero() : Boolean
      {
         var _loc1_:PlayerHeroEntry = player.heroes.getById(DataStorage.rule.townChestRule.superPrizeId);
         return _loc1_ != null;
      }
      
      public function get coinSuperPrize() : InventoryItem
      {
         if(DataStorage.rule.townChestRule.coinSuperPrize)
         {
            return DataStorage.rule.townChestRule.coinSuperPrize.outputDisplay[0];
         }
         return null;
      }
      
      public function get signal_offersUpdated() : Signal
      {
         return player.specialOffer.signal_updated;
      }
      
      public function get signal_questPromoUpdate() : Signal
      {
         return _signal_questPromoUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TownChestFullscreenPopup(this);
         return _popup;
      }
      
      public function action_getFreeOne() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         _loc4_ = null;
         var _loc1_:ChestPopupValueObject = _townChest;
         var _loc3_:Boolean = _loc1_.availableFreeNow;
         if(_loc1_.chest.cost.gold)
         {
            _loc4_ = Stash.click("pick_up:" + _loc1_.chest.ident + ":free",_popup.stashParams);
         }
         else
         {
            _loc4_ = Stash.click("pick_up:" + _loc1_.chest.ident + ":free",_popup.stashParams);
         }
         _loc2_ = GameModel.instance.actionManager.chestBuy(_loc1_.chest,_loc3_,false);
         _loc2_.stashClick = _loc4_;
         _loc2_.signal_complete.add(onChestBuy);
         onSendCommand();
      }
      
      public function action_buySingle() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         _loc4_ = null;
         var _loc1_:ChestPopupValueObject = _townChest;
         var _loc3_:Boolean = _loc1_.availableFreeNow;
         if(_loc1_.chest.cost.gold)
         {
            _loc4_ = Stash.click("pick_up:" + _loc1_.chest.ident + ":" + (!!_loc3_?"free":_loc1_.chest.cost.gold),_popup.stashParams);
         }
         else
         {
            _loc4_ = Stash.click("pick_up:" + _loc1_.chest.ident + ":" + (!!_loc3_?"free":_loc1_.chest.cost.starmoney),_popup.stashParams);
         }
         _loc2_ = GameModel.instance.actionManager.chestBuy(_loc1_.chest,_loc3_,false);
         _loc2_.stashClick = _loc4_;
         _loc2_.signal_complete.add(onChestBuy);
         onSendCommand();
      }
      
      public function action_buyPack() : void
      {
         var _loc2_:* = null;
         var _loc1_:ChestPopupValueObject = _townChest;
         var _loc3_:PopupStashEventParams = Stash.click("pick_up_multi:" + _loc1_.chest.ident + ":" + _loc1_.chest.packAmount + ":" + _loc1_.cost_multi.amount,_popup.stashParams);
         _loc2_ = GameModel.instance.actionManager.chestBuy(_loc1_.chest,false,true);
         _loc2_.stashClick = _loc3_;
         _loc2_.signal_complete.add(onChestBuy);
         onSendCommand();
      }
      
      public function action_showHeroDropList() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Array = [];
         var _loc1_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _townChest.specialHeroReward.length)
         {
            if(_townChest.specialHeroReward[_loc4_].item is HeroDescription)
            {
               _loc6_.push(_townChest.specialHeroReward[_loc4_]);
            }
            _loc1_ = _loc1_ + ("," + _townChest.specialHeroReward[_loc4_].item.name);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _townChest.heroReward.length)
         {
            if(_townChest.heroReward[_loc4_].item is HeroDescription)
            {
               _loc6_.push(_townChest.heroReward[_loc4_]);
            }
            _loc1_ = _loc1_ + ("," + _townChest.heroReward[_loc4_].item.name);
            _loc4_++;
         }
         var _loc2_:int = _townChest.heroMiscReward.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_townChest.heroMiscReward[_loc3_].item is HeroDescription)
            {
               _loc6_.push(_townChest.heroMiscReward[_loc3_]);
            }
            _loc1_ = _loc1_ + ("," + _townChest.heroMiscReward[_loc3_].item.name);
            _loc3_++;
         }
         var _loc5_:ChestRewardHeroesListPopUpMediator = new ChestRewardHeroesListPopUpMediator(player,_loc6_);
         _loc5_.open();
      }
      
      protected function onSendCommand() : void
      {
         HeroRewardPopupHandler.instance.hold();
      }
      
      protected function createHeroListPresentation() : void
      {
         var _loc14_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Vector.<ChestRewardPresentationValueObject> = new Vector.<ChestRewardPresentationValueObject>();
         var _loc15_:Vector.<ChestRewardPresentationValueObject> = DataStorage.chest.CHEST_TOWN.rewardPresentation.hero;
         var _loc2_:Vector.<ChestRewardPresentationValueObject> = DataStorage.chest.CHEST_TOWN.rewardPresentation.misc_hero;
         var _loc7_:Vector.<int> = DataStorage.rule.townChestRule.chestHeroList;
         var _loc10_:Vector.<int> = DataStorage.rule.townChestRule.chestHeroUnlockableList;
         _loc7_ = _loc7_.concat(_loc10_);
         var _loc11_:int = _loc7_.length;
         _loc4_ = 0;
         for(; _loc4_ < _loc11_; _loc4_++)
         {
            _loc3_ = DataStorage.hero.getHeroById(_loc7_[_loc4_]);
            _loc8_ = -1;
            _loc12_ = false;
            _loc13_ = false;
            _loc9_ = _loc15_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc9_)
            {
               if(_loc15_[_loc5_].item.id == _loc3_.id)
               {
                  _loc13_ = true;
                  break;
               }
               _loc5_++;
            }
            if(!_loc13_)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc2_.length)
               {
                  if(_loc2_[_loc6_].item.id == _loc3_.id)
                  {
                     _loc8_ = _loc2_[_loc6_].priority;
                     _loc12_ = _loc2_[_loc6_].is_new;
                  }
                  _loc6_++;
               }
               if(_loc10_.indexOf(_loc3_.id) != -1)
               {
                  if(!player.heroes.getById(_loc3_.id))
                  {
                  }
                  continue;
               }
               if(_loc8_ == -1)
               {
               }
               _loc14_ = new ChestRewardPresentationValueObject(_loc3_,_loc8_,_loc12_);
               _loc1_.push(_loc14_);
               continue;
            }
         }
         _loc8_ = -1;
         _loc12_ = false;
         _loc1_ = CollectionUtil.shuffleVector(_loc1_ as Vector.<*>) as Vector.<ChestRewardPresentationValueObject>;
         _loc1_.sort(_sortHeroList);
         _townChest = new ChestPopupValueObject(player,DataStorage.chest.CHEST_TOWN,player.refillable.getById(DataStorage.chest.CHEST_TOWN.freeRefill),_loc1_);
      }
      
      public function action_registerChestPopupOfferClip(param1:*) : void
      {
         player.specialOffer.hooks.registerTownChestFullscreenPopupClip(param1);
      }
      
      public function action_registerChestGraphicsOfferSpot(param1:DisplayObject) : void
      {
         player.specialOffer.hooks.registerChestPopupChestIcon(param1);
      }
      
      private function _sortHeroList(param1:ChestRewardPresentationValueObject, param2:ChestRewardPresentationValueObject) : int
      {
         var _loc4_:int = int(param1.is_new) * 100;
         var _loc3_:int = int(param2.is_new) * 100;
         _loc4_ = _loc4_ + param1.priority;
         _loc3_ = _loc3_ + param2.priority;
         if(HeroRewardPopupHandler.instance.history.indexOf(param1.item.id) != -1)
         {
            _loc4_ = _loc4_ + 10;
         }
         if(HeroRewardPopupHandler.instance.history.indexOf(param2.item.id) != -1)
         {
            _loc3_ = _loc3_ + 10;
         }
         return _loc3_ - _loc4_;
      }
      
      private function onChestBuy(param1:CommandChestBuy) : void
      {
         var _loc2_:RewardValueObjectList = new RewardValueObjectList(param1.rewardList);
         var _loc3_:ChestRewardPopupValueObject = new ChestRewardPopupValueObject(player,param1.chest,param1.pack,_loc2_);
         var _loc4_:ChestRewardPopupMediator = new ChestRewardPopupMediator(player,_loc3_);
         _loc4_.signal_reBuy.add(handler_chestReBuy);
         _loc4_.open(param1.stashClick);
      }
      
      private function handler_chestReBuy(param1:ChestRewardPopupValueObject, param2:PopupStashEventParams) : void
      {
         var _loc3_:* = null;
         _loc3_ = GameModel.instance.actionManager.chestBuy(param1.chest,false,param1.pack);
         _loc3_.stashClick = param2;
         _loc3_.signal_complete.add(onChestBuy);
         onSendCommand();
      }
      
      private function handler_promoQuestUpdated(param1:PlayerQuestEntry) : void
      {
         if(param1.desc.id == 245)
         {
            _signal_questPromoUpdate.dispatch();
         }
      }
   }
}
