package game.view.popup
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.view.popup.common.resourcepanel.PopupResourcePanelItem;
   import starling.display.Stage;
   
   public class PopupResourceList extends LayoutGroup
   {
      
      public static const INVALIDATION_FLAG_POSITION:String = "INVALIDATION_FLAG_POSITION";
       
      
      private var costPanels:Vector.<PopupResourcePanelItem>;
      
      private var _resourceList:ResourcePanelValueObjectGroup;
      
      public function PopupResourceList()
      {
         super();
         costPanels = new Vector.<PopupResourcePanelItem>();
      }
      
      public function get resourceList() : ResourcePanelValueObjectGroup
      {
         return _resourceList;
      }
      
      public function set resourceList(param1:ResourcePanelValueObjectGroup) : void
      {
         this._resourceList = param1;
         invalidate("data");
      }
      
      public function getPanelByItem(param1:InventoryItemDescription) : PopupResourcePanelItem
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = undefined;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         super.draw();
         if(isInvalid("data"))
         {
            _loc1_ = costPanels.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               removeChild(costPanels[_loc3_].graphics);
               costPanels[_loc3_].dispose();
               _loc3_++;
            }
            costPanels = new Vector.<PopupResourcePanelItem>();
            _loc5_ = _resourceList.data;
            _loc1_ = _loc5_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc6_ = AssetStorage.rsx.popup_theme.create_renderer_resource_panel();
               costPanels[_loc4_] = _loc6_;
               _loc6_.signal_resize.add(handler_panelResize);
               _loc6_.data = _loc5_[_loc4_];
               addChild(_loc6_.graphics);
               _loc4_++;
            }
            invalidate("INVALIDATION_FLAG_POSITION");
         }
         if(isInvalid("INVALIDATION_FLAG_POSITION"))
         {
            _loc2_ = this.stage;
            if(_loc2_)
            {
               x = Math.round(_loc2_.stageWidth - width) - 20;
               y = 10;
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layout = new HorizontalLayout();
         (layout as HorizontalLayout).gap = 10;
      }
      
      private function handler_panelResize() : void
      {
         invalidate("size");
         invalidate("INVALIDATION_FLAG_POSITION");
      }
   }
}
