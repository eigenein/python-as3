package game.view.popup.artifactstore
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.artifact.CommandArtifactFragmentBuy;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.CoinDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.artifacts.PlayerHeroWithArtifactsVO;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ArtifactStorePopupMediator extends PopupMediator
   {
       
      
      private var artifactFragmentsInventory:InventoryCollection;
      
      private var _hero:PlayerHeroEntryValueObject;
      
      public const miniHeroListDataProvider:ListCollection = new ListCollection();
      
      private var _signal_heroUpdated:Signal;
      
      private var _signal_heroArtifactUpgrade:Signal;
      
      private var _signal_playerInventoryUpdate:Signal;
      
      public function ArtifactStorePopupMediator(param1:Player, param2:HeroDescription = null)
      {
         _signal_heroUpdated = new Signal();
         _signal_heroArtifactUpgrade = new Signal();
         _signal_playerInventoryUpdate = new Signal();
         super(param1);
         artifactFragmentsInventory = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.ARTIFACT);
         artifactFragmentsInventory.updateSignal.add(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.add(handler_inventoryUpdate);
         createMiniList();
         if(param2)
         {
            setHero(param2);
         }
         else
         {
            setHero((miniHeroListDataProvider.getItemAt(0) as PlayerHeroWithArtifactsVO).hero);
         }
      }
      
      override protected function dispose() : void
      {
         artifactFragmentsInventory.updateSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory = null;
         setHero(null);
         super.dispose();
      }
      
      public function get hero() : PlayerHeroEntryValueObject
      {
         return _hero;
      }
      
      public function get miniHeroListSelectedItem() : PlayerHeroWithArtifactsVO
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<PlayerHeroWithArtifactsVO> = miniHeroListDataProvider.data as Vector.<PlayerHeroWithArtifactsVO>;
         if(!_loc2_)
         {
            return null;
         }
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_loc2_[_loc3_].hero == hero.hero)
            {
               return _loc2_[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function get storeArtifacts() : Vector.<ArtifactDescription>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<ArtifactDescription> = new Vector.<ArtifactDescription>();
         if(hero)
         {
            _loc2_ = 0;
            while(_loc2_ < hero.playerEntry.artifacts.list.length)
            {
               _loc1_.push(hero.playerEntry.artifacts.list[_loc2_].desc);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function get signal_heroUpdated() : Signal
      {
         return _signal_heroUpdated;
      }
      
      public function get signal_heroArtifactUpgrade() : Signal
      {
         return _signal_heroArtifactUpgrade;
      }
      
      public function get playerHasSubscription() : Boolean
      {
         return player.subscription.subscriptionInfo.isActive;
      }
      
      public function get signal_playerInventoryUpdate() : Signal
      {
         return _signal_playerInventoryUpdate;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         if(hero)
         {
            _loc3_ = hero.playerEntry.artifacts.list[0];
            if(_loc3_)
            {
               _loc1_ = _loc3_.desc.fragmentBuyCost;
               if(_loc1_ && _loc1_.outputDisplayFirst)
               {
                  _loc2_.requre_coin(_loc1_.outputDisplayFirst.item as CoinDescription);
               }
            }
         }
         return _loc2_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArtifactStorePopup(this);
         return _popup;
      }
      
      public function getAmountText(param1:ArtifactDescription) : String
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:String = ColorUtils.hexToRGBFormat(16573879) + Translate.translate("UI_DIALOG_INVENTORY_AMOUNT") + " ";
         if(hero)
         {
            _loc5_ = null;
            _loc3_ = 0;
            while(_loc3_ < hero.playerEntry.artifacts.list.length)
            {
               if(hero.playerEntry.artifacts.list[_loc3_].desc.id == param1.id)
               {
                  _loc5_ = hero.playerEntry.artifacts.list[_loc3_];
                  break;
               }
               _loc3_++;
            }
            if(_loc5_)
            {
               _loc6_ = uint(player.inventory.getFragmentCollection().getItemCount(param1));
               if(!_loc5_.maxStars)
               {
                  _loc4_ = uint(_loc5_.nextEvolutionStar.costFragmentsAmount);
                  if(_loc6_ < _loc4_)
                  {
                     _loc2_ = _loc2_ + (ColorUtils.hexToRGBFormat(11220276) + _loc6_ + ColorUtils.hexToRGBFormat(16573879) + "/" + _loc4_);
                  }
                  else
                  {
                     _loc2_ = _loc2_ + (ColorUtils.hexToRGBFormat(16645626) + _loc6_ + "/" + _loc4_);
                  }
               }
               else
               {
                  _loc2_ = _loc2_ + (ColorUtils.hexToRGBFormat(16645626) + _loc6_);
               }
            }
         }
         return _loc2_;
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerHeroWithArtifactsVO) : void
      {
         setHero(param1.hero);
      }
      
      public function action_buy(param1:ArtifactDescription) : void
      {
         var _loc2_:CommandArtifactFragmentBuy = GameModel.instance.actionManager.hero.artifactFragmentBuy(param1,1);
      }
      
      public function action_navigate_subscription() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.SUBSCRIPTION,Stash.click("subscription",_popup.stashParams));
      }
      
      public function action_navigate_artifacts(param1:ArtifactDescription) : void
      {
         PopupList.instance.dialog_artifacts(_hero.hero,param1,Stash.click("hero_artifacts",_popup.stashParams));
      }
      
      private function handler_artifactBuy(param1:RPCCommandBase) : void
      {
         var _loc3_:CommandArtifactFragmentBuy = param1 as CommandArtifactFragmentBuy;
         _loc3_.signal_complete.remove(handler_artifactBuy);
         var _loc2_:ArtifactStorePurchasePopup = new ArtifactStorePurchasePopup(new InventoryFragmentItem(_loc3_.artifact,_loc3_.amount));
         _loc2_.stashSourceClick = _popup.stashParams;
         PopUpManager.addPopUp(_loc2_);
      }
      
      private function setHero(param1:HeroDescription) : void
      {
         if(_hero)
         {
            _hero.playerEntry.signal_artifactEvolve.remove(handler_heroArtifactEvolve);
            _hero.playerEntry.signal_artifactLevelUp.remove(handler_heroArtifactLevelUp);
         }
         _hero = !!param1?new PlayerHeroEntryValueObject(param1,player.heroes.getById(param1.id)):null;
         if(_hero)
         {
            _hero.playerEntry.signal_artifactEvolve.add(handler_heroArtifactEvolve);
            _hero.playerEntry.signal_artifactLevelUp.add(handler_heroArtifactLevelUp);
         }
         signal_heroUpdated.dispatch();
      }
      
      private function createMiniList() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc1_:Vector.<PlayerHeroWithArtifactsVO> = new Vector.<PlayerHeroWithArtifactsVO>();
         var _loc2_:Vector.<HeroDescription> = DataStorage.hero.getPlayableHeroes();
         var _loc3_:int = _loc2_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc6_];
            if(_loc5_.isPlayable)
            {
               _loc4_ = player.heroes.getById(_loc5_.id);
               if(_loc4_)
               {
                  _loc7_ = new PlayerHeroWithArtifactsVO(_loc5_,player);
                  _loc1_.push(_loc7_);
               }
            }
            _loc6_++;
         }
         _loc1_.sort(PlayerHeroListValueObject.sort);
         miniHeroListDataProvider.data = _loc1_;
      }
      
      private function handler_inventoryUpdate(param1:InventoryItem) : void
      {
         signal_playerInventoryUpdate.dispatch();
      }
      
      private function handler_heroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_heroArtifactUpgrade.dispatch();
      }
      
      private function handler_heroArtifactEvolve(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_heroArtifactUpgrade.dispatch();
      }
   }
}
