package game.mediator.gui.popup.titanspiritartifact
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.titanspiritartifact.TitanSpiritArtifactPopup;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.textures.Texture;
   
   public class TitanSpiritArtifactPopupMediator extends PopupMediator
   {
       
      
      private var artifactFragmentsInventory:InventoryCollection;
      
      public var selectedArtifact:PlayerTitanArtifact;
      
      public var spiritArtifactList:Vector.<PlayerTitanArtifactVO>;
      
      private var _signal_titanArtifactEvolveStar:Signal;
      
      private var _signal_titanArtifactLevelUp:Signal;
      
      private var _signal_inventoryUpdate:Signal;
      
      private var _signal_artifactUpdated:Signal;
      
      public function TitanSpiritArtifactPopupMediator(param1:Player, param2:PlayerTitanArtifact = null)
      {
         _signal_titanArtifactEvolveStar = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         _signal_titanArtifactLevelUp = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         _signal_inventoryUpdate = new Signal();
         _signal_artifactUpdated = new Signal();
         super(param1);
         if(param2)
         {
            selectedArtifact = param2;
         }
         else
         {
            selectedArtifact = param1.titans.getSpiritArtifactById(4002);
         }
         spiritArtifactList = new Vector.<PlayerTitanArtifactVO>();
         spiritArtifactList.push(new PlayerTitanArtifactVO(param1,param1.titans.getSpiritArtifactById(4001),null));
         spiritArtifactList.push(new PlayerTitanArtifactVO(param1,param1.titans.getSpiritArtifactById(4002),null));
         spiritArtifactList.push(new PlayerTitanArtifactVO(param1,param1.titans.getSpiritArtifactById(4003),null));
         param1.titans.signal_titanArtifactEvolveStar.add(handler_titanArtifactEvolveStar);
         param1.titans.signal_titanArtifactLevelUp.add(handler_titanArtifactLevelUp);
         artifactFragmentsInventory = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.TITAN_ARTIFACT);
         artifactFragmentsInventory.updateSignal.add(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.add(handler_inventoryUpdate);
      }
      
      override protected function dispose() : void
      {
         player.titans.signal_titanArtifactEvolveStar.remove(handler_titanArtifactEvolveStar);
         player.titans.signal_titanArtifactLevelUp.remove(handler_titanArtifactLevelUp);
         artifactFragmentsInventory.updateSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory = null;
         super.dispose();
      }
      
      public function get artifactNextLevelCost() : CostData
      {
         if(selectedArtifact && selectedArtifact.nextLevelData)
         {
            return selectedArtifact.nextLevelData.cost;
         }
         return null;
      }
      
      public function get artifactNextLevelCostStarmoney() : CostData
      {
         if(selectedArtifact && selectedArtifact.nextLevelData)
         {
            return selectedArtifact.nextLevelData.costStarmoney;
         }
         return null;
      }
      
      public function get artifactNextStarRecipe() : Vector.<InventoryItemValueObject>
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:Vector.<InventoryItemValueObject> = new Vector.<InventoryItemValueObject>();
         if(selectedArtifact)
         {
            _loc2_ = selectedArtifact.nextEvolutionStar;
            if(_loc2_)
            {
               _loc1_.push(new InventoryItemValueObject(player,new InventoryFragmentItem(selectedArtifact.desc,_loc2_.costFragmentsAmount)));
               _loc3_ = 0;
               while(_loc3_ < _loc2_.costBase.outputDisplay.length)
               {
                  _loc1_.push(new InventoryItemValueObject(player,_loc2_.costBase.outputDisplay[_loc3_]));
                  _loc3_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function get artifactIsAvaliable() : Boolean
      {
         if(selectedArtifact)
         {
            return true;
         }
         return false;
      }
      
      public function get artifactAwaked() : Boolean
      {
         if(selectedArtifact)
         {
            return selectedArtifact.awakened;
         }
         return false;
      }
      
      public function get artifactMaxLevel() : Boolean
      {
         if(selectedArtifact)
         {
            return selectedArtifact.maxLevel;
         }
         return false;
      }
      
      public function get artifactMaxStars() : Boolean
      {
         if(selectedArtifact)
         {
            return selectedArtifact.maxStars;
         }
         return false;
      }
      
      public function get artifactAnimationName() : String
      {
         if(selectedArtifact)
         {
            switch(int(selectedArtifact.desc.id) - 4001)
            {
               case 0:
                  return "spirit_water_" + (selectedArtifact.stars + 1);
               case 1:
                  return "spirit_fire_" + (selectedArtifact.stars + 1);
               case 2:
                  return "spirit_earth_" + (selectedArtifact.stars + 1);
            }
         }
         return null;
      }
      
      public function get upgradeAnimationName() : String
      {
         if(selectedArtifact)
         {
            switch(int(selectedArtifact.desc.id) - 4001)
            {
               case 0:
                  return "upgrade_fx1";
               case 1:
                  return "upgrade_fx2";
               case 2:
                  return "upgrade_fx3";
            }
         }
         return null;
      }
      
      public function get levelUpAnimationName() : String
      {
         if(selectedArtifact)
         {
            switch(int(selectedArtifact.desc.id) - 4001)
            {
               case 0:
                  return "levelup_fx1";
               case 1:
                  return "levelup_fx2";
               case 2:
                  return "levelup_fx3";
            }
         }
         return null;
      }
      
      public function get skillIcon() : Texture
      {
         var _loc1_:SkillDescription = new SkillDescription(null);
         _loc1_.icon_assetAtlas = 1;
         _loc1_.icon_assetTexture = "skill_Titan_" + selectedArtifact.desc.element.toLowerCase();
         return AssetStorage.skillIcon.getItemTexture(_loc1_);
      }
      
      public function get artifactDescText() : String
      {
         return ColorUtils.hexToRGBFormat(15919178) + Translate.translate("LIB_TITAN_ARTIFACT_DESC_SPIRIT_" + selectedArtifact.desc.element.toUpperCase());
      }
      
      public function get signal_titanArtifactEvolveStar() : Signal
      {
         return _signal_titanArtifactEvolveStar;
      }
      
      public function get signal_titanArtifactLevelUp() : Signal
      {
         return _signal_titanArtifactLevelUp;
      }
      
      public function get signal_inventoryUpdate() : Signal
      {
         return _signal_inventoryUpdate;
      }
      
      public function get signal_artifactUpdated() : Signal
      {
         return _signal_artifactUpdated;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanSpiritArtifactPopup(this);
         return new TitanSpiritArtifactPopup(this);
      }
      
      public function getArtifactSkillHeader() : String
      {
         return Translate.translate("LIB_SKILL_TITAN_SPIRIT_ARTIFACT_HEADER_" + selectedArtifact.desc.id);
      }
      
      public function getArtifactSkillName() : String
      {
         return Translate.translate("UI_BATTLE_TITAN_SPIRIT_NAME_" + selectedArtifact.desc.element.toUpperCase());
      }
      
      public function getArtifactSkillDesc(param1:Boolean = false, param2:Boolean = false) : String
      {
         var _loc3_:String = BattleStatValueObjectProvider.getTitanArtifactStats(selectedArtifact,param1,param2,false,true);
         return Translate.translateArgs("LIB_SKILL_DESC_TITAN_SPIRIT_ARTIFACT_" + selectedArtifact.desc.id,_loc3_);
      }
      
      public function getArtifactSkillAvaliableText() : String
      {
         return Translate.translate("LIB_SKILL_DESC2_TITAN_SPIRIT_ARTIFACT_" + selectedArtifact.desc.id);
      }
      
      public function getStatsTitle(param1:Boolean = false, param2:Boolean = false) : String
      {
         var _loc3_:String = "";
         if(param1 && selectedArtifact.awakened)
         {
            _loc3_ = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_AFTER_EVOLUTION");
         }
         else if(param2)
         {
            _loc3_ = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_AFTER_LEVEL_UP");
         }
         else if(!artifactAwaked)
         {
            _loc3_ = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_AFTER_INVOKE");
         }
         else
         {
            _loc3_ = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_STATS");
         }
         return _loc3_;
      }
      
      public function getStatsText(param1:Boolean = false, param2:Boolean = false, param3:Boolean = true) : String
      {
         return BattleStatValueObjectProvider.getTitanArtifactStats(selectedArtifact,param1,param2,param3);
      }
      
      public function action_selectRecipeItem(param1:InventoryItemValueObject) : void
      {
         PopupList.instance.popup_artifact_recipe_item_info(param1.inventoryItem.item,null,Stash.click("item_info",_popup.stashParams));
      }
      
      public function action_level_up() : void
      {
         GameModel.instance.actionManager.titan.titanSpiritArtifactLevelUp(selectedArtifact,false);
      }
      
      public function action_level_up_starmoney() : void
      {
         GameModel.instance.actionManager.titan.titanSpiritArtifactLevelUp(selectedArtifact,true);
      }
      
      public function action_evolve() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].artifacts.spirit == selectedArtifact)
            {
               _loc3_ = true;
               break;
            }
            _loc2_++;
         }
         if(_loc3_)
         {
            if(checkItemsInPlayerInventory(artifactNextStarRecipe))
            {
               GameModel.instance.actionManager.titan.titanSpiritArtifactEvolve(selectedArtifact);
            }
            else
            {
               action_selectRecipeItem(artifactNextStarRecipe[0]);
            }
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_TITAN_ARENA_NEGATIVE_TEXT_SPIRIT"));
         }
      }
      
      public function action_artifactsListSelectionUpdate(param1:PlayerTitanArtifactVO) : void
      {
         if(param1)
         {
            setArtifact(param1.artifact);
         }
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc2_:* = null;
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         _loc1_.requre_consumable(DataStorage.consumable.getTitanSparkDesc());
         if(selectedArtifact)
         {
            if(selectedArtifact.nextLevelData && selectedArtifact.nextLevelData.cost)
            {
               _loc2_ = selectedArtifact.nextLevelData.cost;
            }
            else if(selectedArtifact.prevLevelData && selectedArtifact.prevLevelData.cost)
            {
               _loc2_ = selectedArtifact.prevLevelData.cost;
            }
            else
            {
               _loc2_ = selectedArtifact.currentLevelData.cost;
            }
            if(_loc2_.outputDisplayFirst.item is ConsumableDescription)
            {
               _loc1_.requre_consumable(_loc2_.outputDisplayFirst.item as ConsumableDescription);
            }
            else if(_loc2_.outputDisplayFirst.item is CoinDescription)
            {
               _loc1_.requre_coin(_loc2_.outputDisplayFirst.item as CoinDescription);
            }
         }
         return _loc1_;
      }
      
      private function setArtifact(param1:PlayerTitanArtifact) : void
      {
         selectedArtifact = param1;
         GamePopupManager.instance.resourcePanel.setMediator(_popup as TitanSpiritArtifactPopup,GamePopupManager.instance.root);
         signal_artifactUpdated.dispatch();
      }
      
      private function checkItemsInPlayerInventory(param1:Vector.<InventoryItemValueObject>) : Boolean
      {
         var _loc3_:* = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].inventoryItem is InventoryFragmentItem)
            {
               _loc3_ = uint(player.inventory.getFragmentCollection().getItemCount(param1[_loc2_].item));
            }
            else
            {
               _loc3_ = uint(player.inventory.getItemCollection().getItemCount(param1[_loc2_].item));
            }
            if(_loc3_ < param1[_loc2_].amount)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function handler_titanArtifactEvolveStar(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         signal_titanArtifactEvolveStar.dispatch(param1,param2);
      }
      
      private function handler_titanArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         signal_titanArtifactLevelUp.dispatch(param1,param2);
         GamePopupManager.instance.resourcePanel.setMediator(_popup as TitanSpiritArtifactPopup,GamePopupManager.instance.root);
      }
      
      private function handler_inventoryUpdate(param1:InventoryItem) : void
      {
         signal_inventoryUpdate.dispatch();
      }
   }
}
