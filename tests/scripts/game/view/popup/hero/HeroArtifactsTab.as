package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.popup.artifacts.PlayerHeroArtifactMarkeredItemRenderer;
   
   public class HeroArtifactsTab extends GuiClipNestedContainer
   {
       
      
      public var _mediator:HeroPopupMediator;
      
      public var artifact_:Vector.<PlayerHeroArtifactMarkeredItemRenderer>;
      
      public var button_go:ClipButtonLabeled;
      
      public function HeroArtifactsTab()
      {
         artifact_ = new Vector.<PlayerHeroArtifactMarkeredItemRenderer>();
         button_go = new ClipButtonLabeled();
         super();
      }
      
      public function get mediator() : HeroPopupMediator
      {
         return _mediator;
      }
      
      public function set mediator(param1:HeroPopupMediator) : void
      {
         if(_mediator)
         {
            button_go.signal_click.remove(handler_go);
            _mediator.signal_heroArtifactUpgrade.remove(handler_heroArtifactUpgrade);
         }
         _mediator = param1;
         if(_mediator)
         {
            button_go.signal_click.add(handler_go);
            _mediator.signal_heroArtifactUpgrade.add(handler_heroArtifactUpgrade);
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<PlayerHeroArtifactVO> = mediator.heroArtifactsList;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            artifact_[_loc1_].setData(_loc2_[_loc1_]);
            _loc1_++;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         _loc2_ = 0;
         while(_loc2_ < artifact_.length)
         {
            artifact_[_loc2_].signal_click.add(handler_artifactClick);
            _loc2_++;
         }
         button_go.label = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_NAVIGATE_TO_ARTIFACTS");
      }
      
      private function handler_go() : void
      {
         _mediator.action_navigate_to_artifacts();
      }
      
      private function handler_artifactClick(param1:PlayerHeroArtifactVO) : void
      {
         if(param1)
         {
            mediator.action_navigate_to_artifacts(param1.artifact.desc);
         }
      }
      
      private function handler_heroArtifactUpgrade() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < artifact_.length)
         {
            artifact_[_loc1_].updateRedDotState();
            _loc1_++;
         }
      }
   }
}
