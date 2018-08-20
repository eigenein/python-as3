package game.view.popup.artifacts
{
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.zeppelin.popup.ZeppelinPopupBase;
   import game.mediator.gui.popup.artifacts.HeroArtifactsPopupMediator;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.mediator.gui.popup.artifacts.PlayerHeroWithArtifactsVO;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.popup.IEscClosable;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroList;
   import starling.events.Event;
   
   public class HeroArtifactsPopup extends ZeppelinPopupBase implements IEscClosable
   {
       
      
      private var mediator:HeroArtifactsPopupMediator;
      
      private var evolutionHover:TouchHoverContoller;
      
      private var levelUpHover:TouchHoverContoller;
      
      private var clip:HeroArtifactsPopupClip;
      
      private var miniList:HeroPopupMiniHeroList;
      
      private var artifatsList:List;
      
      public function HeroArtifactsPopup(param1:HeroArtifactsPopupMediator)
      {
         super(param1,AssetStorage.rsx.artifact_graphics);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.signal_heroUpdated.remove(handler_heroUpdate);
         mediator.signal_artifactUpdated.remove(handler_artifactUpdate);
         mediator.signal_heroArtifactEvolveStar.remove(handler_heroArtifactEvolveStar);
         mediator.signal_heroArtifactLevelUp.remove(handler_heroArtifactLevelUp);
         if(miniList)
         {
            miniList.removeEventListener("change",handler_miniListSelectionChange);
         }
         if(artifatsList)
         {
            artifatsList.removeEventListener("change",handler_artifactsListSelectionChange);
         }
         if(clip)
         {
            clip.level_up_clip.craft_recipe_list.signal_itemSelected.remove(handler_selectItem);
            clip.evolve_clip.craft_recipe_list.signal_itemSelected.remove(handler_selectItem);
         }
         if(evolutionHover)
         {
            evolutionHover.dispose();
         }
         if(levelUpHover)
         {
            levelUpHover.dispose();
         }
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         height = 500;
         mediator.signal_heroUpdated.add(handler_heroUpdate);
         mediator.signal_artifactUpdated.add(handler_artifactUpdate);
         mediator.signal_heroArtifactEvolveStar.add(handler_heroArtifactEvolveStar);
         mediator.signal_heroArtifactLevelUp.add(handler_heroArtifactLevelUp);
         clip = AssetStorage.rsx.artifact_graphics.create(HeroArtifactsPopupClip,"dialog_hero_artifacts");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         HeroArtifactListRenderer.mediator = mediator;
         artifatsList = new List();
         artifatsList.addEventListener("change",handler_artifactsListSelectionChange);
         artifatsList.layout = new VerticalLayout();
         (artifatsList.layout as VerticalLayout).gap = -7;
         artifatsList.itemRendererType = HeroArtifactListRenderer;
         artifatsList.horizontalScrollPolicy = "off";
         artifatsList.verticalScrollPolicy = "off";
         artifatsList.width = clip.artifacts_list_container.container.width;
         artifatsList.height = clip.artifacts_list_container.container.height;
         clip.artifacts_list_container.container.addChild(artifatsList);
         createMiniList();
         clip.evolve_clip.mediator = mediator;
         clip.level_up_clip.mediator = mediator;
         clip.info.mediator = mediator;
         clip.level_up_clip.craft_recipe_list.signal_itemSelected.add(handler_selectItem);
         clip.evolve_clip.craft_recipe_list.signal_itemSelected.add(handler_selectItem);
         evolutionHover = new TouchHoverContoller(clip.evolve_clip.action_button.container);
         evolutionHover.signal_hoverChanger.add(handler_evolutionHoverChanged);
         levelUpHover = new TouchHoverContoller(clip.level_up_clip.action_button.container);
         levelUpHover.signal_hoverChanger.add(handler_levelUpHoverChanged);
         handler_heroUpdate();
      }
      
      private function handler_heroUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = int(artifatsList.selectedIndex);
         artifatsList.dataProvider = new ListCollection(mediator.heroArtifactsList);
         if(mediator.selectedArtifact)
         {
            _loc1_ = 0;
            while(_loc1_ < artifatsList.dataProvider.length)
            {
               if((artifatsList.dataProvider.getItemAt(_loc1_) as PlayerHeroArtifactVO).artifact.desc == mediator.selectedArtifact)
               {
                  _loc2_ = _loc1_;
                  break;
               }
               _loc1_++;
            }
         }
         artifatsList.selectedIndex = _loc2_ >= 0?_loc2_:0;
      }
      
      private function createMiniList() : void
      {
         miniList = new HeroPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow);
         miniList.itemRendererType = HeroArtifactsMiniHeroListItem;
         miniList.dataProvider = mediator.miniHeroListDataProvider;
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerHeroWithArtifactsVO);
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
      }
      
      private function handler_artifactsListSelectionChange(param1:Event) : void
      {
         mediator.selectedArtifact = null;
         mediator.action_artifactsListSelectionUpdate(artifatsList.selectedItem as PlayerHeroArtifactVO);
      }
      
      private function handler_artifactUpdate() : void
      {
         clip.info.updateState();
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_heroArtifactEvolveStar(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         clip.info.updateState(true,false);
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_heroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         clip.info.updateState(false,true);
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_evolutionHoverChanged() : void
      {
         clip.info.updateStats(evolutionHover.hover,false);
      }
      
      private function handler_levelUpHoverChanged() : void
      {
         clip.info.updateStats(false,levelUpHover.hover);
      }
      
      private function handler_selectItem(param1:Object) : void
      {
         mediator.action_selectRecipeItem(param1 as InventoryItemValueObject);
      }
   }
}
