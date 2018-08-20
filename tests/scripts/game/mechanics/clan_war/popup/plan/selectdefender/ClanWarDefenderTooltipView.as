package game.mechanics.clan_war.popup.plan.selectdefender
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObjectContainer;
   
   public class ClanWarDefenderTooltipView extends TooltipTextView
   {
       
      
      private const clip:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      private var _label_busy:GameLabel;
      
      public function ClanWarDefenderTooltipView()
      {
         super();
      }
      
      override protected function createElements() : void
      {
         _label = GameLabel.special16();
         _label.wordWrap = true;
         _label.maxWidth = 450;
         addChild(_label);
         _label_busy = GameLabel.special16();
         AssetStorage.rsx.popup_theme.initGuiClip(clip,"mini_hero_team");
         addChild(clip.graphics);
         addChild(_label_busy);
      }
      
      override public function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void
      {
         var _loc3_:* = null;
         if(param1.tooltipVO.hintData)
         {
            param2.addChild(this);
            _loc3_ = param1.tooltipVO.hintData;
            _label.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translate("UI_DIALOG_ARENA_MY_TEAM");
            clip.setUnitTeam(_loc3_.team);
            if(_loc3_.currentSlotDesc)
            {
               _label_busy.text = Translate.translateArgs("UI_CLAN_WAR_DEFENDER_IS_BUSY_AT_SLOT",_loc3_.currentSlotDesc.fortificationDesc.name,_loc3_.currentSlotDesc.index + 1);
            }
            _label_busy.visible = _loc3_.currentSlot > 0;
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
