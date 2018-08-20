package game.view.popup.hero.slot
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class ClipListItemDropSourceMissionBlock extends GuiClipNestedContainer
   {
       
      
      private var _tooltipVO:TooltipVO;
      
      public var tf_chapter_label:ClipLabel;
      
      public var tf_mission_label:ClipLabel;
      
      public var tf_count_label:ClipLabel;
      
      public var tf_red_label:ClipLabel;
      
      public var mission_hgroup:ClipLayout;
      
      private var _mediator:ClipListItemDropSourceRendererMediator;
      
      public function ClipListItemDropSourceMissionBlock()
      {
         tf_chapter_label = new ClipLabel();
         tf_mission_label = new ClipLabel(true);
         tf_count_label = new ClipLabel(true);
         tf_red_label = new ClipLabel();
         mission_hgroup = ClipLayout.horizontal(5,tf_mission_label,tf_count_label);
         super();
      }
      
      public function get mediator() : ClipListItemDropSourceRendererMediator
      {
         return _mediator;
      }
      
      public function set mediator(param1:ClipListItemDropSourceRendererMediator) : void
      {
         if(mediator == param1)
         {
            return;
         }
         _mediator = param1;
         if(mediator)
         {
            mediator.signalDataUpdate.add(onDataUpdate);
            mediator.signalEliteTriesUpdate.add(onDataUpdate);
            onDataUpdate();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_mission_label.maxWidth = 177;
      }
      
      public function dispose() : void
      {
         if(mediator)
         {
            mediator.signalDataUpdate.remove(onDataUpdate);
            mediator.signalEliteTriesUpdate.remove(onDataUpdate);
         }
      }
      
      private function updateTooltip() : void
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = mediator.missionItemDropVO.enabled;
         var _loc2_:Boolean = mediator.lockedByTeamLevel;
         var _loc1_:String = null;
         if(!_loc3_ || _loc2_)
         {
            if(_loc3_ && _loc2_)
            {
               _loc1_ = Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",mediator.missionItemDropVO.teamLevel);
            }
            else
            {
               _loc4_ = "UI_DIALOG_HERO_INVENTORY_SLOT_MISSION_NOT_AVAILABLE";
               if(Translate.has(_loc4_))
               {
                  _loc1_ = Translate.translate(_loc4_);
               }
            }
         }
         if(_loc1_)
         {
            if(!_tooltipVO)
            {
               _tooltipVO = new TooltipVO(TooltipTextView,_loc1_);
            }
            else
            {
               _tooltipVO.hintData = _loc1_;
            }
            TooltipHelper.addTooltip(graphics,_tooltipVO);
         }
         else
         {
            TooltipHelper.removeTooltip(graphics);
         }
      }
      
      private function onDataUpdate() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(mediator && mediator.missionItemDropVO)
         {
            _loc2_ = mediator.missionItemDropVO.enabled && !mediator.lockedByTeamLevel;
            _loc1_ = mediator.missionItemDropVO.enabled;
            tf_chapter_label.text = mediator.missionItemDropVO.worldName;
            tf_mission_label.text = mediator.missionItemDropVO.name;
            if(mediator.missionHasEliteTries && _loc1_)
            {
               tf_count_label.text = mediator.eliteTriesAvailable + "/" + mediator.eliteTriesMax;
            }
            else
            {
               tf_count_label.text = "";
            }
            tf_red_label.text = !!_loc2_?"":Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_NOT_AVAILABLE");
            updateTooltip();
         }
      }
   }
}
