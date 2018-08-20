package game.view.gui.components.tooltip
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.view.gui.components.GameLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObjectContainer;
   
   public class HeroArtifactTooltip extends TooltipTextView
   {
       
      
      private var artifact:PlayerHeroArtifact;
      
      private var params:GameLabel;
      
      public function HeroArtifactTooltip()
      {
         super();
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         param2.addChild(this);
         commitData(param1.tooltipVO.hintData);
         draw();
      }
      
      override protected function createElements() : void
      {
         _label = GameLabel.special16();
         params = GameLabel.special16();
         var _loc1_:* = true;
         params.wordWrap = _loc1_;
         _label.wordWrap = _loc1_;
         _loc1_ = 450;
         params.maxWidth = _loc1_;
         _label.maxWidth = _loc1_;
         addChild(_label);
         addChild(params);
      }
      
      override protected function createLayout() : void
      {
         layout = new VerticalLayout();
         (layout as VerticalLayout).verticalAlign = "middle";
         (layout as VerticalLayout).horizontalAlign = "left";
         (layout as VerticalLayout).padding = 20;
      }
      
      protected function commitData(param1:*) : void
      {
         var _loc2_:PlayerHeroArtifact = param1 as PlayerHeroArtifact;
         if(this.artifact == _loc2_)
         {
            return;
         }
         if(this.artifact)
         {
            this.artifact.signal_evolve.remove(handler_update);
            this.artifact.signal_levelUp.remove(handler_update);
         }
         this.artifact = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         this.artifact.signal_evolve.add(handler_update);
         this.artifact.signal_levelUp.add(handler_update);
         handler_update();
      }
      
      private function handler_update() : void
      {
         _label.text = artifact.desc.name;
         addChild(_label);
         if(!artifact.awakened)
         {
            params.text = ColorUtils.hexToRGBFormat(16568453) + Translate.translate("UI_TOOLTIP_ARTIFACT_NOT_AWAKED");
         }
         else
         {
            params.text = getStatsText();
         }
         addChild(params);
      }
      
      public function getStatsText(param1:Boolean = false, param2:Boolean = false) : String
      {
         return BattleStatValueObjectProvider.getArtifactStats(artifact,param1,param2);
      }
   }
}
