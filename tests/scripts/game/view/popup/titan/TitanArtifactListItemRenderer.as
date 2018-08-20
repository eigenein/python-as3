package game.view.popup.titan
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.titan.PlayerTitanArtifactListValueObject;
   import game.mediator.gui.popup.titan.PlayerTitanListValueObject;
   import game.mediator.gui.popup.titan.TitanListItemRendererBase;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   
   public class TitanArtifactListItemRenderer extends TitanListItemRendererBase implements ITutorialActionProvider
   {
       
      
      private var _signal_select:Signal;
      
      private var _vo:PlayerTitanArtifactListValueObject;
      
      public function TitanArtifactListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerTitanListValueObject);
      }
      
      override public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
         super.dispose();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get vo() : PlayerTitanArtifactListValueObject
      {
         return _vo;
      }
      
      protected function get clip() : TitanArtifactListPopupItemClip
      {
         return assetClip as TitanArtifactListPopupItemClip;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(this.vo)
         {
            _loc2_.addButtonWithKey(TutorialNavigator.TITAN_ARTIFACT,assetClip.bg_button,this.vo.titan);
         }
         return _loc2_;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerTitanListValueObject = data as PlayerTitanListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateLevel.remove(handler_levelUpdate);
            _loc2_.signal_updateArtifactUpgradeAvaliable.remove(handler_updateArtifactUpgradeAvaliable);
            _loc2_.signal_updateSpiritArtifactUpgradeAvaliable.remove(handler_updateSpiritArtifactUpgradeAvaliable);
         }
         .super.data = param1;
         _vo = data as PlayerTitanArtifactListValueObject;
         if(_vo)
         {
            vo.signal_updateLevel.add(handler_levelUpdate);
            vo.signal_updateArtifactUpgradeAvaliable.add(handler_updateArtifactUpgradeAvaliable);
            vo.signal_updateSpiritArtifactUpgradeAvaliable.remove(handler_updateSpiritArtifactUpgradeAvaliable);
         }
         if(clip)
         {
            clip.NewIcon_inst0.graphics.visible = false;
         }
         Tutorial.addActionsFrom(this);
      }
      
      override protected function commitData() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         if(_vo)
         {
            clip.tf_hero_name.text = vo.name;
            _loc1_ = _vo.titanArtifactsList;
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               clip.artifact[_loc2_].setData(_loc1_[_loc2_]);
               _loc2_++;
            }
            clip.NewIcon_inst0.graphics.visible = vo.redDotState;
         }
         super.commitData();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = clip.bg_button.graphics.width;
         height = clip.bg_button.graphics.height;
         clip.NewIcon_inst0.graphics.touchable = false;
      }
      
      override protected function createClip() : void
      {
         assetClip = AssetStorage.rsx.popup_theme.create_dialog_titan_artifact_list_item();
         addChild(assetClip.graphics);
      }
      
      override protected function listener_buttonClick() : void
      {
         _signal_select.dispatch(data as PlayerTitanListValueObject);
      }
      
      private function handler_levelUpdate() : void
      {
         portrait.update_level();
      }
      
      private function handler_updateArtifactUpgradeAvaliable() : void
      {
         clip.NewIcon_inst0.graphics.visible = vo.redDotState;
      }
      
      private function handler_updateSpiritArtifactUpgradeAvaliable() : void
      {
         clip.NewIcon_inst0.graphics.visible = vo.redDotState;
      }
   }
}
