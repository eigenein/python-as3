package game.view.popup.hero.slot
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   
   public class ClipListItemDropSourceRendererClip extends GuiClipNestedContainer
   {
       
      
      public var mission_info:ClipListItemDropSourceMissionBlock;
      
      public var button:ClipButtonLabeled;
      
      private var _mediator:ClipListItemDropSourceRendererMediator;
      
      public function ClipListItemDropSourceRendererClip()
      {
         button = new ClipButtonLabeled();
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
            mission_info.mediator = mediator;
            onDataUpdate();
         }
      }
      
      public function dispose() : void
      {
         mission_info.dispose();
         if(mediator)
         {
            mediator.signalDataUpdate.remove(onDataUpdate);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button.label = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST_GET");
      }
      
      private function onDataUpdate() : void
      {
         if(mediator && mediator.missionItemDropVO)
         {
            button.graphics.visible = mediator.missionItemDropVO.enabled && !mediator.lockedByTeamLevel;
         }
      }
   }
}
