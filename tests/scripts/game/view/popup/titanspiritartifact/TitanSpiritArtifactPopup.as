package game.view.popup.titanspiritartifact
{
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.titanspiritartifact.TitanSpiritArtifactPopupMediator;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import starling.events.Event;
   
   public class TitanSpiritArtifactPopup extends AsyncClipBasedPopupWithPreloader implements IEscClosable
   {
       
      
      private var mediator:TitanSpiritArtifactPopupMediator;
      
      private var clip:TitanSpiritArtifactPopupClip;
      
      private var artifatsList:List;
      
      private var title:PopupTitle;
      
      private var _progressAsset:RequestableAsset;
      
      private var evolutionHover:TouchHoverContoller;
      
      private var levelUpHover1:TouchHoverContoller;
      
      private var levelUpHover2:TouchHoverContoller;
      
      public function TitanSpiritArtifactPopup(param1:TitanSpiritArtifactPopupMediator)
      {
         super(param1,AssetStorage.rsx.artifact_graphics);
         this.mediator = param1;
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.big_pillars,AssetStorage.rsx.titan_artifact_icons_large,AssetStorage.rsx.artifact_graphics,AssetStorage.rsx.titan_artifact_icons);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         mediator.signal_titanArtifactEvolveStar.remove(handler_titanArtifactEvolveStar);
         mediator.signal_titanArtifactLevelUp.remove(handler_titanArtifactLevelUp);
         mediator.signal_artifactUpdated.remove(handler_artifactUpdate);
         if(evolutionHover)
         {
            evolutionHover.dispose();
         }
         if(levelUpHover1)
         {
            levelUpHover1.dispose();
         }
         if(levelUpHover2)
         {
            levelUpHover2.dispose();
         }
         if(clip)
         {
            clip.evolve_clip.craft_recipe_list.signal_itemSelected.remove(mediator.action_selectRecipeItem);
         }
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         mediator.signal_titanArtifactEvolveStar.add(handler_titanArtifactEvolveStar);
         mediator.signal_titanArtifactLevelUp.add(handler_titanArtifactLevelUp);
         mediator.signal_artifactUpdated.add(handler_artifactUpdate);
         clip = AssetStorage.rsx.artifact_graphics.create(TitanSpiritArtifactPopupClip,"dialog_titan_spirit_artifact");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width - 80;
         height = clip.dialog_frame.graphics.height - 50;
         clip.button_close.signal_click.add(close);
         title = PopupTitle.create(mediator.selectedArtifact.desc.name,clip.header_layout_container);
         clip.info.mediator = mediator;
         clip.level_up_clip.mediator = mediator;
         clip.evolve_clip.mediator = mediator;
         clip.evolve_clip.craft_recipe_list.signal_itemSelected.add(mediator.action_selectRecipeItem);
         evolutionHover = new TouchHoverContoller(clip.evolve_clip.action_button.container);
         evolutionHover.signal_hoverChanger.add(handler_evolutionHoverChanged);
         levelUpHover1 = new TouchHoverContoller(clip.level_up_clip.button_level_up_1.container);
         levelUpHover1.signal_hoverChanger.add(handler_levelUpHover1Changed);
         levelUpHover2 = new TouchHoverContoller(clip.level_up_clip.button_level_up_2.container);
         levelUpHover2.signal_hoverChanger.add(handler_levelUpHover2Changed);
         TitanSpiritArtifactListRenderer.mediator = mediator;
         artifatsList = new List();
         artifatsList.addEventListener("change",handler_artifactsListSelectionChange);
         artifatsList.layout = new VerticalLayout();
         (artifatsList.layout as VerticalLayout).gap = 0;
         artifatsList.itemRendererType = TitanSpiritArtifactListRenderer;
         artifatsList.dataProvider = new ListCollection(mediator.spiritArtifactList);
         artifatsList.horizontalScrollPolicy = "off";
         artifatsList.verticalScrollPolicy = "off";
         artifatsList.width = clip.minilist_layout_container.container.width;
         artifatsList.height = clip.minilist_layout_container.container.height;
         clip.minilist_layout_container.container.addChild(artifatsList);
         handler_artifactUpdate();
         updateArtifatsListSelection();
      }
      
      private function updateArtifatsListSelection() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = int(artifatsList.selectedIndex);
         if(mediator.selectedArtifact)
         {
            _loc1_ = 0;
            while(_loc1_ < artifatsList.dataProvider.length)
            {
               if((artifatsList.dataProvider.getItemAt(_loc1_) as PlayerTitanArtifactVO).artifact == mediator.selectedArtifact)
               {
                  _loc2_ = _loc1_;
                  break;
               }
               _loc1_++;
            }
         }
         artifatsList.selectedIndex = _loc2_ >= 0?_loc2_:0;
      }
      
      private function handler_artifactUpdate() : void
      {
         title.text = mediator.selectedArtifact.desc.name;
         clip.info.updateState();
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_artifactsListSelectionChange(param1:Event) : void
      {
         mediator.action_artifactsListSelectionUpdate(artifatsList.selectedItem as PlayerTitanArtifactVO);
      }
      
      private function handler_titanArtifactEvolveStar(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         clip.info.updateState(true,false);
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_titanArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         clip.info.updateState(false,true);
         clip.evolve_clip.updateState();
         clip.level_up_clip.updateState();
      }
      
      private function handler_evolutionHoverChanged() : void
      {
         clip.info.updateStats(evolutionHover.hover,false);
      }
      
      private function handler_levelUpHover1Changed() : void
      {
         clip.info.updateStats(false,levelUpHover1.hover);
      }
      
      private function handler_levelUpHover2Changed() : void
      {
         clip.info.updateStats(false,levelUpHover2.hover);
      }
   }
}
