package game.view.popup.hero
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.mediator.gui.popup.hero.PlayerHeroArtifactListValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import idv.cjcat.signals.Signal;
   
   public class HeroArtifactListItemRenderer extends HeroListItemRendererBase
   {
       
      
      private var _signal_select:Signal;
      
      private var _vo:PlayerHeroArtifactListValueObject;
      
      public function HeroArtifactListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerHeroListValueObject);
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get vo() : PlayerHeroArtifactListValueObject
      {
         return _vo;
      }
      
      protected function get clip() : HeroArtifactListPopupItemClip
      {
         return assetClip as HeroArtifactListPopupItemClip;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerHeroListValueObject = data as PlayerHeroListValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateLevel.remove(handler_levelUpdate);
            _loc2_.signal_updateArtifactUpgradeAvaliable.remove(handler_updateArtifactUpgradeAvaliable);
         }
         .super.data = param1;
         _vo = data as PlayerHeroArtifactListValueObject;
         if(_vo)
         {
            vo.signal_updateLevel.add(handler_levelUpdate);
            vo.signal_updateArtifactUpgradeAvaliable.add(handler_updateArtifactUpgradeAvaliable);
         }
         if(clip)
         {
            clip.NewIcon_inst0.graphics.visible = false;
         }
      }
      
      override protected function commitData() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         if(_vo)
         {
            clip.tf_hero_name.text = vo.name;
            _loc1_ = _vo.heroArtifactsList;
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
         assetClip = AssetStorage.rsx.popup_theme.create_dialog_hero_artifact_list_item();
         addChild(assetClip.graphics);
      }
      
      override protected function listener_buttonClick() : void
      {
         _signal_select.dispatch(data as PlayerHeroListValueObject);
      }
      
      private function handler_levelUpdate() : void
      {
         portrait.update_level();
      }
      
      private function handler_updateArtifactUpgradeAvaliable() : void
      {
         clip.NewIcon_inst0.graphics.visible = vo.redDotState;
      }
   }
}
