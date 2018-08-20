package game.view.popup.reward
{
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.popup.mission.MissionDropValueObject;
   import game.view.gui.components.InventoryItemDescriptionRenderer;
   
   public class MissionEnterPopupRewardItemRenderer extends InventoryItemDescriptionRenderer
   {
       
      
      private var externalStyle:GuiElementExternalStyle;
      
      public function MissionEnterPopupRewardItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(externalStyle)
         {
            externalStyle.dispose();
            externalStyle = null;
         }
         super.dispose();
      }
      
      public function get vo() : MissionDropValueObject
      {
         return data as MissionDropValueObject;
      }
      
      override protected function updateItemFrame() : void
      {
         if(!vo)
         {
            return;
         }
         itemFrame.texture = AssetStorageUtil.getItemFrameTexture(vo.item);
         externalStyle = vo.createExternalStyle();
         if(externalStyle)
         {
            externalStyle.apply(this,this.parent.parent,this.parent.parent);
         }
      }
      
      override protected function updateTooltip() : void
      {
         _tooltipVO.hintData = vo.item;
      }
      
      override protected function commitData() : void
      {
         if(externalStyle)
         {
            externalStyle.dispose();
            externalStyle = null;
         }
         if(vo)
         {
            commitDataDesc(vo.item.item);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
   }
}
