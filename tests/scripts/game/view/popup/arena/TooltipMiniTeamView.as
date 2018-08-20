package game.view.popup.arena
{
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.model.user.arena.IUnitEntryValueObjectTeamProvider;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.DisplayObjectContainer;
   
   public class TooltipMiniTeamView extends TooltipTextView
   {
       
      
      private const clip:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public function TooltipMiniTeamView()
      {
         super();
      }
      
      override protected function createElements() : void
      {
         AssetStorage.rsx.popup_theme.initGuiClip(clip,"mini_hero_team");
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:* = null;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _loc3_ = param1.tooltipVO.hintData;
            addChild(clip.graphics);
            clip.setUnitTeam(_loc3_.getTeam(0));
            draw();
         }
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         layout = _loc1_;
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.gap = 5;
         _loc1_.padding = 15;
      }
   }
}
