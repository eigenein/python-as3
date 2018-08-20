package game.view.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.model.user.arena.IUnitEntryValueObjectTeamProvider;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObjectContainer;
   
   public class TooltipArenaEnemyTeamView extends TooltipTextView
   {
       
      
      private const clip:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public function TooltipArenaEnemyTeamView()
      {
         super();
      }
      
      override protected function createElements() : void
      {
         _label = GameLabel.special16();
         _label.wordWrap = true;
         _label.maxWidth = 450;
         addChild(_label);
         AssetStorage.rsx.popup_theme.initGuiClip(clip,"mini_hero_team");
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:* = null;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _label.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translate("UI_TOWER_ENEMY_TEAM");
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
