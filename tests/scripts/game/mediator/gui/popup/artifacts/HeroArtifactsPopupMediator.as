package game.mediator.gui.popup.artifacts
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.textures.Scale3Textures;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.ArtifactLevel;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.artifacts.HeroArtifactsPopup;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroArtifactsPopupMediator extends PopupMediator
   {
       
      
      private var artifactFragmentsInventory:InventoryCollection;
      
      private var _hero:PlayerHeroEntryValueObject;
      
      private var _selectedArtifact:ArtifactDescription;
      
      private var _artifact:PlayerHeroArtifact;
      
      public const miniHeroListDataProvider:ListCollection = new ListCollection();
      
      private var _signal_statsUpdate:Signal;
      
      private var _signal_heroUpdated:Signal;
      
      private var _signal_artifactUpdated:Signal;
      
      private var _signal_heroArtifactEvolveStar:Signal;
      
      private var _signal_heroArtifactLevelUp:Signal;
      
      private var _signal_inventoryUpdate:Signal;
      
      public function HeroArtifactsPopupMediator(param1:Player, param2:ArtifactDescription, param3:HeroDescription)
      {
         _signal_statsUpdate = new Signal(Vector.<BattleStatValueObject>);
         _signal_heroUpdated = new Signal();
         _signal_artifactUpdated = new Signal();
         _signal_heroArtifactEvolveStar = new Signal(PlayerHeroEntry,PlayerHeroArtifact);
         _signal_heroArtifactLevelUp = new Signal(PlayerHeroEntry,PlayerHeroArtifact);
         _signal_inventoryUpdate = new Signal();
         super(param1);
         this.selectedArtifact = param2;
         setHero(param3);
         createMiniList();
         param1.heroes.signal_heroArtifactEvolveStar.add(handler_heroArtifactEvolveStar);
         param1.heroes.signal_heroArtifactLevelUp.add(handler_heroArtifactLevelUp);
         artifactFragmentsInventory = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.ARTIFACT);
         artifactFragmentsInventory.updateSignal.add(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.add(handler_inventoryUpdate);
      }
      
      override protected function dispose() : void
      {
         player.heroes.signal_heroArtifactEvolveStar.remove(handler_heroArtifactEvolveStar);
         player.heroes.signal_heroArtifactLevelUp.remove(handler_heroArtifactLevelUp);
         artifactFragmentsInventory.updateSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory.updateCountSignal.remove(handler_inventoryUpdate);
         artifactFragmentsInventory = null;
         setHero(null);
         setArtifact(null);
         miniHeroListDataProvider.removeAll();
         super.dispose();
      }
      
      public function get hero() : PlayerHeroEntryValueObject
      {
         return _hero;
      }
      
      public function get selectedArtifact() : ArtifactDescription
      {
         return _selectedArtifact;
      }
      
      public function set selectedArtifact(param1:ArtifactDescription) : void
      {
         _selectedArtifact = param1;
      }
      
      public function get artifact() : PlayerHeroArtifact
      {
         return _artifact;
      }
      
      public function get artifactNextLevelRecipe() : Vector.<InventoryItemValueObject>
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:Vector.<InventoryItemValueObject> = new Vector.<InventoryItemValueObject>();
         if(artifact)
         {
            _loc3_ = artifact.nextLevelData;
            if(_loc3_)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc3_.cost.outputDisplay.length)
               {
                  _loc1_.push(new InventoryItemValueObject(player,_loc3_.cost.outputDisplay[_loc2_]));
                  _loc2_++;
               }
            }
         }
         return _loc1_;
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
      
      public function get heroArtifactsList() : Vector.<PlayerHeroArtifactVO>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerHeroArtifactVO> = new Vector.<PlayerHeroArtifactVO>();
         if(hero)
         {
            _loc2_ = 0;
            while(_loc2_ < hero.playerEntry.artifacts.list.length)
            {
               _loc1_.push(new PlayerHeroArtifactVO(player,hero.playerEntry.artifacts.list[_loc2_],hero.playerEntry));
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function get artifactIsAvaliable() : Boolean
      {
         if(hero && artifact)
         {
            return artifact.desc.artifactTypeData.minHeroLevel <= hero.level;
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
      
      public function get artifactMinHeroLevel() : uint
      {
         if(artifact)
         {
            return artifact.desc.artifactTypeData.minHeroLevel;
         }
         return 0;
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
            _loc3_ = DataStorage.skill.getByHero(hero.hero.id);
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
            _loc1_ = ColorUtils.hexToRGBFormat(16568453) + Translate.translateArgs("LIB_ARTIFACT_DESC_" + artifact.desc.artifactType.toUpperCase(),ColorUtils.hexToRGBFormat(16645626) + _loc2_ + ColorUtils.hexToRGBFormat(16568453),artifact.desc.effectDuration);
         }
         else
         {
            _loc1_ = ColorUtils.hexToRGBFormat(16568453) + Translate.translate("LIB_ARTIFACT_DESC_" + artifact.desc.artifactType.toUpperCase());
         }
         return _loc1_;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      public function get signal_statsUpdate() : Signal
      {
         return _signal_statsUpdate;
      }
      
      public function get signal_heroUpdated() : Signal
      {
         return _signal_heroUpdated;
      }
      
      public function get signal_artifactUpdated() : Signal
      {
         return _signal_artifactUpdated;
      }
      
      public function get signal_heroArtifactEvolveStar() : Signal
      {
         return _signal_heroArtifactEvolveStar;
      }
      
      public function get signal_heroArtifactLevelUp() : Signal
      {
         return _signal_heroArtifactLevelUp;
      }
      
      public function get signal_inventoryUpdate() : Signal
      {
         return _signal_inventoryUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroArtifactsPopup(this);
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
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc4_:* = 0;
         var _loc14_:* = null;
         var _loc17_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc16_:* = null;
         var _loc11_:int = 0;
         var _loc6_:Number = NaN;
         var _loc12_:String = "";
         if(artifact.desc.artifactType == "weapon")
         {
            _loc4_ = uint(0);
            if(artifact.awakened)
            {
               _loc10_ = artifact.currentEvolutionStar.applyChancePercent;
               if(!artifact.maxStars && param1)
               {
                  _loc4_ = uint(artifact.nextEvolutionStar.applyChancePercent - _loc10_);
               }
               if(!artifact.maxStars && param1 && _loc4_ > 0)
               {
                  _loc5_ = ColorUtils.hexToRGBFormat(16645626) + _loc10_ + "%" + ColorUtils.hexToRGBFormat(15919178) + " +" + _loc4_ + "%";
               }
               else
               {
                  _loc5_ = ColorUtils.hexToRGBFormat(16645626) + _loc10_ + "%";
               }
            }
            else
            {
               _loc5_ = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_FROM_TO_ONE_LINE",artifact.nextEvolutionStar.applyChancePercent + "%",artifact.maxEvolutionStar.applyChancePercent + "%");
            }
            _loc12_ = _loc12_ + (ColorUtils.hexToRGBFormat(16568453) + Translate.translate("UI_DIALOG_HERO_ARTIFACTS_APPLY_CHANCE") + ": " + _loc5_ + "\n");
         }
         var _loc13_:Vector.<BattleStatValueObject> = new Vector.<BattleStatValueObject>();
         var _loc15_:Array = [];
         var _loc3_:Array = [];
         var _loc7_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < artifact.desc.battleEffectsData.length)
         {
            _loc14_ = artifact.desc.battleEffectsData[_loc8_].levels[artifact.level] as BattleStats;
            _loc17_ = BattleStatValueObjectProvider.fromBattleStats(_loc14_);
            _loc9_ = 0;
            while(_loc9_ < _loc17_.length)
            {
               _loc13_.push(_loc17_[_loc9_]);
               if(artifact.awakened)
               {
                  _loc15_.push(Math.round(_loc17_[_loc9_].statValue * artifact.currentEvolutionStar.battleEffectMultiplier));
               }
               _loc9_++;
            }
            _loc14_ = artifact.desc.battleEffectsData[_loc8_].levels[artifact.maxLevelData.level] as BattleStats;
            _loc17_ = BattleStatValueObjectProvider.fromBattleStats(_loc14_);
            _loc9_ = 0;
            while(_loc9_ < _loc17_.length)
            {
               _loc7_.push(Math.round(_loc17_[_loc9_].statValue * artifact.maxEvolutionStar.battleEffectMultiplier));
               _loc9_++;
            }
            if(param1 || param2 || !artifact.awakened)
            {
               if(param2)
               {
                  _loc14_ = artifact.desc.battleEffectsData[_loc8_].levels[artifact.level + 1] as BattleStats;
               }
               else
               {
                  _loc14_ = artifact.desc.battleEffectsData[_loc8_].levels[artifact.level] as BattleStats;
               }
               _loc17_ = BattleStatValueObjectProvider.fromBattleStats(_loc14_);
               _loc9_ = 0;
               while(_loc9_ < _loc17_.length)
               {
                  if(param1 || !artifact.awakened)
                  {
                     _loc3_.push(Math.round(_loc17_[_loc9_].statValue * artifact.nextEvolutionStar.battleEffectMultiplier));
                  }
                  else
                  {
                     _loc3_.push(Math.round(_loc17_[_loc9_].statValue * artifact.currentEvolutionStar.battleEffectMultiplier));
                  }
                  _loc9_++;
               }
            }
            _loc8_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc13_.length)
         {
            if(!artifact.awakened)
            {
               if(_loc13_[_loc11_].isPercentage)
               {
                  _loc16_ = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_FROM_TO_ONE_LINE",_loc3_[_loc11_] + "%",_loc7_[_loc11_] + "%");
               }
               else
               {
                  _loc16_ = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_FROM_TO_ONE_LINE",_loc3_[_loc11_],_loc7_[_loc11_]);
               }
            }
            else if(param1 || param2)
            {
               _loc6_ = Math.round(_loc3_[_loc11_] - _loc15_[_loc11_]);
               if(_loc13_[_loc11_].isPercentage)
               {
                  _loc16_ = ColorUtils.hexToRGBFormat(16645626) + _loc15_[_loc11_] + "%" + ColorUtils.hexToRGBFormat(15919178) + String.fromCharCode(160) + "+" + _loc6_ + "%";
               }
               else
               {
                  _loc16_ = ColorUtils.hexToRGBFormat(16645626) + "+" + _loc15_[_loc11_] + ColorUtils.hexToRGBFormat(15919178) + String.fromCharCode(160) + "+" + _loc6_;
               }
            }
            else if(_loc13_[_loc11_].isPercentage)
            {
               _loc16_ = ColorUtils.hexToRGBFormat(16645626) + _loc15_[_loc11_] + "%";
            }
            else
            {
               _loc16_ = ColorUtils.hexToRGBFormat(16645626) + "+" + _loc15_[_loc11_];
            }
            _loc12_ = _loc12_ + (ColorUtils.hexToRGBFormat(16568453) + _loc13_[_loc11_].name + ": " + _loc16_);
            if(_loc11_ < _loc13_.length - 1)
            {
               _loc12_ = _loc12_ + "\n";
            }
            _loc11_++;
         }
         return _loc12_;
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerHeroWithArtifactsVO) : void
      {
         setHero(param1.hero);
      }
      
      public function action_artifactsListSelectionUpdate(param1:PlayerHeroArtifactVO) : void
      {
         if(param1)
         {
            setArtifact(param1);
         }
      }
      
      public function action_selectRecipeItem(param1:InventoryItemValueObject) : void
      {
         PopupList.instance.popup_artifact_recipe_item_info(param1.inventoryItem.item,hero.hero,Stash.click("item_info",_popup.stashParams));
      }
      
      public function action_level_up() : void
      {
         if(checkItemsInPlayerInventory(artifactNextLevelRecipe))
         {
            GameModel.instance.actionManager.hero.heroArtifactLevelUp(hero.playerEntry,artifact);
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_HERO_ARTIFACTS_NOT_ENOUGH"));
         }
      }
      
      public function action_evolve() : void
      {
         if(checkItemsInPlayerInventory(artifactNextStarRecipe))
         {
            GameModel.instance.actionManager.hero.heroArtifactEvolve(hero.playerEntry,artifact);
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_HERO_ARTIFACTS_NOT_ENOUGH"));
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
      
      private function setHero(param1:HeroDescription) : void
      {
         _hero = !!param1?new PlayerHeroEntryValueObject(param1,player.heroes.getById(param1.id)):null;
         signal_heroUpdated.dispatch();
      }
      
      private function setArtifact(param1:PlayerHeroArtifactVO) : void
      {
         _artifact = !!param1?param1.artifact:null;
         signal_artifactUpdated.dispatch();
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
      
      private function handler_heroArtifactEvolveStar(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_heroArtifactEvolveStar.dispatch(param1,param2);
      }
      
      private function handler_heroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_heroArtifactLevelUp.dispatch(param1,param2);
      }
      
      private function handler_inventoryUpdate(param1:InventoryItem) : void
      {
         signal_inventoryUpdate.dispatch();
      }
   }
}
