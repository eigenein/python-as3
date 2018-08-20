package game.mediator.gui.popup.artifacts
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.textures.Scale3Textures;
   import game.assets.storage.AssetStorage;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.titan.PlayerTitanEntryValueObject;
   import game.mediator.gui.popup.titan.PlayerTitanListValueObject;
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
   import game.view.popup.artifacts.TitanArtifactsPopup;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TitanArtifactsPopupMediator extends PopupMediator
   {
       
      
      private var artifactFragmentsInventory:InventoryCollection;
      
      private var _titan:PlayerTitanEntryValueObject;
      
      private var _selectedArtifact:TitanArtifactDescription;
      
      private var _artifact:PlayerTitanArtifact;
      
      public const miniTitanListDataProvider:ListCollection = new ListCollection();
      
      private var _signal_statsUpdate:Signal;
      
      private var _signal_titanUpdated:Signal;
      
      private var _signal_artifactUpdated:Signal;
      
      private var _signal_titanArtifactEvolveStar:Signal;
      
      private var _signal_titanArtifactLevelUp:Signal;
      
      private var _signal_inventoryUpdate:Signal;
      
      private var _signal_goldUpdate:Signal;
      
      public function TitanArtifactsPopupMediator(param1:Player, param2:TitanArtifactDescription, param3:TitanDescription)
      {
         _signal_statsUpdate = new Signal(Vector.<BattleStatValueObject>);
         _signal_titanUpdated = new Signal();
         _signal_artifactUpdated = new Signal();
         _signal_titanArtifactEvolveStar = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         _signal_titanArtifactLevelUp = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         _signal_inventoryUpdate = new Signal();
         _signal_goldUpdate = new Signal();
         super(param1);
         this.selectedArtifact = param2;
         setTitan(param3);
         createMiniList();
         param1.titans.signal_titanArtifactEvolveStar.add(handler_titanArtifactEvolveStar);
         param1.titans.signal_titanArtifactLevelUp.add(handler_titanArtifactLevelUp);
         artifactFragmentsInventory = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.TITAN_ARTIFACT);
         artifactFragmentsInventory.updateSignal.add(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.add(handler_inventoryUpdate);
         param1.signal_update.gold.add(handler_goldUpdate);
      }
      
      override protected function dispose() : void
      {
         player.titans.signal_titanArtifactEvolveStar.remove(handler_titanArtifactEvolveStar);
         player.titans.signal_titanArtifactLevelUp.remove(handler_titanArtifactLevelUp);
         artifactFragmentsInventory.updateSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory = null;
         player.signal_update.gold.remove(handler_goldUpdate);
         setTitan(null);
         setArtifact(null);
         miniTitanListDataProvider.removeAll();
         super.dispose();
      }
      
      public function get titan() : PlayerTitanEntryValueObject
      {
         return _titan;
      }
      
      public function get selectedArtifact() : TitanArtifactDescription
      {
         return _selectedArtifact;
      }
      
      public function set selectedArtifact(param1:TitanArtifactDescription) : void
      {
         _selectedArtifact = param1;
      }
      
      public function get artifact() : PlayerTitanArtifact
      {
         return _artifact;
      }
      
      public function get artifactPrevLevelCost() : CostData
      {
         if(artifact && artifact.prevLevelData)
         {
            return artifact.prevLevelData.cost;
         }
         return null;
      }
      
      public function get artifactNextLevelCost() : CostData
      {
         if(artifact && artifact.nextLevelData)
         {
            return artifact.nextLevelData.cost;
         }
         return null;
      }
      
      public function get artifactNextLevelCostStarmoney() : CostData
      {
         if(artifact && artifact.nextLevelData)
         {
            return artifact.nextLevelData.costStarmoney;
         }
         return null;
      }
      
      public function get artifactNextStarRecipe() : Vector.<InventoryItemValueObject>
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:Vector.<InventoryItemValueObject> = new Vector.<InventoryItemValueObject>();
         if(artifact)
         {
            _loc2_ = artifact.nextEvolutionStar;
            if(_loc2_)
            {
               _loc1_.push(new InventoryItemValueObject(player,new InventoryFragmentItem(artifact.desc,_loc2_.costFragmentsAmount)));
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
      
      public function get titanArtifactsList() : Vector.<PlayerTitanArtifactVO>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerTitanArtifactVO> = new Vector.<PlayerTitanArtifactVO>();
         if(titan)
         {
            _loc2_ = 0;
            while(_loc2_ < titan.playerEntry.artifacts.list.length)
            {
               _loc1_.push(new PlayerTitanArtifactVO(player,titan.playerEntry.artifacts.list[_loc2_],titan.playerEntry));
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function get artifactIsAvaliable() : Boolean
      {
         if(titan && artifact)
         {
            return artifact.desc.artifactTypeData.minHeroLevel <= titan.level;
         }
         return false;
      }
      
      public function get artifactAwaked() : Boolean
      {
         if(artifact)
         {
            return artifact.awakened;
         }
         return false;
      }
      
      public function get artifactMaxLevel() : Boolean
      {
         if(artifact)
         {
            return artifact.maxLevel;
         }
         return false;
      }
      
      public function get artifactMaxStars() : Boolean
      {
         if(artifact)
         {
            return artifact.maxStars;
         }
         return false;
      }
      
      public function get artifactMinTitanLevel() : uint
      {
         if(artifact)
         {
            return artifact.desc.artifactTypeData.minHeroLevel;
         }
         return 0;
      }
      
      public function get miniTitanListSelectedItem() : PlayerTitanWithArtifactsVO
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<PlayerTitanWithArtifactsVO> = miniTitanListDataProvider.data as Vector.<PlayerTitanWithArtifactsVO>;
         if(!_loc2_)
         {
            return null;
         }
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_loc2_[_loc3_].titan == titan.titan)
            {
               return _loc2_[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function get ribbonTexture() : Scale3Textures
      {
         var _loc1_:* = artifact.color;
         if("green" !== _loc1_)
         {
            if("blue" !== _loc1_)
            {
               if("purple" !== _loc1_)
               {
                  if("orange" !== _loc1_)
                  {
                     return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonWhiteHeader_76_76_1",76,1);
                  }
                  return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonGoldHeader_76_76_1",76,1);
               }
               return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonPurpleHeader_76_76_1",76,1);
            }
            return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonBlueHeader_76_76_1",76,1);
         }
         return AssetStorage.rsx.popup_theme.getScale3Textures("RibbonGreenHeader_76_76_1",76,1);
      }
      
      public function get artifactDescText() : String
      {
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc1_:String = "";
         if(artifact.desc.artifactType == "weapon")
         {
            _loc2_ = "";
            _loc3_ = DataStorage.skill.getByHero(titan.titan.id);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_].ultimate)
               {
                  _loc2_ = Translate.translate("LIB_SKILL_" + _loc3_[_loc4_].id);
                  break;
               }
               _loc4_++;
            }
            _loc1_ = ColorUtils.hexToRGBFormat(16568453) + Translate.translateArgs(titanArtifactDescIdent);
         }
         else
         {
            _loc1_ = ColorUtils.hexToRGBFormat(16568453) + Translate.translate(titanArtifactDescIdent);
         }
         return _loc1_;
      }
      
      public function get titanArtifactDescIdent() : String
      {
         if(artifact.desc.artifactType == "armor")
         {
            return (String("LIB_TITAN_ARTIFACT_DESC_" + artifact.desc.artifactType + "_" + titan.titan.details.element)).toUpperCase();
         }
         if(artifact.desc.artifactType == "amulet")
         {
            return (String("LIB_TITAN_ARTIFACT_DESC_" + artifact.desc.artifactType)).toUpperCase();
         }
         return (String("LIB_TITAN_ARTIFACT_DESC_" + titan.titan.details.element)).toUpperCase();
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         _loc1_.requre_gold();
         _loc1_.requre_consumable(DataStorage.consumable.getTitanSparkDesc());
         var _loc3_:CostData = null;
         var _loc2_:PlayerTitanArtifact = titan.playerEntry.artifacts.list[0];
         if(_loc2_)
         {
            if(_loc2_.nextLevelData && _loc2_.nextLevelData.cost)
            {
               _loc3_ = _loc2_.nextLevelData.cost;
            }
            else if(_loc2_.prevLevelData && _loc2_.prevLevelData.cost)
            {
               _loc3_ = _loc2_.prevLevelData.cost;
            }
         }
         if(_loc3_.outputDisplayFirst.item is ConsumableDescription)
         {
            _loc1_.requre_consumable(_loc3_.outputDisplayFirst.item as ConsumableDescription);
         }
         else if(_loc3_.outputDisplayFirst.item is CoinDescription)
         {
            _loc1_.requre_coin(_loc3_.outputDisplayFirst.item as CoinDescription);
         }
         return _loc1_;
      }
      
      public function get signal_statsUpdate() : Signal
      {
         return _signal_statsUpdate;
      }
      
      public function get signal_titanUpdated() : Signal
      {
         return _signal_titanUpdated;
      }
      
      public function get signal_artifactUpdated() : Signal
      {
         return _signal_artifactUpdated;
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
      
      public function get signal_goldUpdate() : Signal
      {
         return _signal_goldUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArtifactsPopup(this);
         return _popup;
      }
      
      public function getStatsTitle(param1:Boolean = false, param2:Boolean = false) : String
      {
         var _loc3_:String = "";
         if(param1 && artifact.awakened)
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
      
      public function getStatsText(param1:Boolean = false, param2:Boolean = false) : String
      {
         return BattleStatValueObjectProvider.getTitanArtifactStats(artifact,param1,param2);
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerTitanWithArtifactsVO) : void
      {
         setTitan(param1.titan);
      }
      
      public function action_artifactsListSelectionUpdate(param1:PlayerTitanArtifactVO) : void
      {
         if(param1)
         {
            setArtifact(param1);
         }
      }
      
      public function action_selectRecipeItem(param1:InventoryItemValueObject) : void
      {
         PopupList.instance.popup_artifact_recipe_item_info(param1.inventoryItem.item,titan.titan,Stash.click("item_info",_popup.stashParams));
      }
      
      public function action_level_up() : void
      {
         GameModel.instance.actionManager.titan.titanArtifactLevelUp(titan.playerEntry,artifact);
      }
      
      public function action_level_up_starmoney() : void
      {
         GameModel.instance.actionManager.titan.titanArtifactLevelUpStarmoney(titan.playerEntry,artifact);
      }
      
      public function action_evolve() : void
      {
         if(checkItemsInPlayerInventory(artifactNextStarRecipe))
         {
            GameModel.instance.actionManager.titan.titanArtifactEvolve(titan.playerEntry,artifact);
         }
         else
         {
            action_selectRecipeItem(artifactNextStarRecipe[0]);
         }
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
      
      private function setTitan(param1:TitanDescription) : void
      {
         _titan = !!param1?new PlayerTitanEntryValueObject(param1,player.titans.getById(param1.id)):null;
         signal_titanUpdated.dispatch();
      }
      
      private function setArtifact(param1:PlayerTitanArtifactVO) : void
      {
         _artifact = !!param1?param1.artifact:null;
         signal_artifactUpdated.dispatch();
      }
      
      private function createMiniList() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc1_:Vector.<PlayerTitanWithArtifactsVO> = new Vector.<PlayerTitanWithArtifactsVO>();
         var _loc4_:Vector.<TitanDescription> = DataStorage.titan.getPlayableTitans();
         var _loc2_:int = _loc4_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = _loc4_[_loc6_];
            if(_loc5_.isPlayable)
            {
               _loc3_ = player.titans.getById(_loc5_.id);
               if(_loc3_)
               {
                  _loc7_ = new PlayerTitanWithArtifactsVO(_loc5_,player);
                  _loc1_.push(_loc7_);
               }
            }
            _loc6_++;
         }
         _loc1_.sort(PlayerTitanListValueObject.sort);
         miniTitanListDataProvider.data = _loc1_;
      }
      
      private function handler_titanArtifactEvolveStar(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         signal_titanArtifactEvolveStar.dispatch(param1,param2);
      }
      
      private function handler_titanArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         signal_titanArtifactLevelUp.dispatch(param1,param2);
      }
      
      private function handler_inventoryUpdate(param1:InventoryItem) : void
      {
         signal_inventoryUpdate.dispatch();
      }
      
      private function handler_goldUpdate() : void
      {
         signal_goldUpdate.dispatch();
      }
   }
}
