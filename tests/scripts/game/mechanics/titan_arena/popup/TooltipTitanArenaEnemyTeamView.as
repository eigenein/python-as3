package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.model.user.arena.IUnitEntryValueObjectTeamProvider;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.display.DisplayObjectContainer;
   
   public class TooltipTitanArenaEnemyTeamView extends TooltipTextView
   {
       
      
      private const clip:TooltipTitanArenaEnemyViewTeamClip = new TooltipTitanArenaEnemyViewTeamClip();
      
      public function TooltipTitanArenaEnemyTeamView()
      {
         super();
      }
      
      override protected function createElements() : void
      {
         _label = GameLabel.special16();
         _label.wordWrap = true;
         _label.maxWidth = 450;
         addChild(_label);
         (AssetStorage.rsx.getByName(TitanArenaPopup.ASSET_IDENT) as RsxGuiAsset).initGuiClip(clip,"enemy_tooltip_clip");
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _loc3_ = param1.tooltipVO.hintData;
            _loc4_ = _loc3_ as PlayerTitanArenaEnemy;
            _label.visible = false;
            clip.tf_nickname.text = _loc4_.nickname;
            addChild(clip.graphics);
            clip.team.setUnitTeam(_loc3_.getTeam(0));
            clip.tf_label_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
            clip.tf_power.text = _loc4_.power.toString();
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
         _loc1_.padding = 10;
      }
   }
}
