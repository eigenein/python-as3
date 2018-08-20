package game.view.popup.clan.activitystats
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   import starling.filters.ColorMatrixFilter;
   
   public class ClanActivityStatsColumnHeaderClip extends DataClipButton
   {
       
      
      public var tf_name:ClipLabel;
      
      public var icon:ClipSprite;
      
      public var layout_group:ClipLayout;
      
      public var bg:ClipSprite;
      
      public function ClanActivityStatsColumnHeaderClip()
      {
         tf_name = new ClipLabel(true);
         icon = new ClipSprite();
         layout_group = ClipLayout.horizontalMiddleCentered(2,tf_name,icon);
         super(ClanActivityStatsColumnHeaderClip);
      }
      
      public function dispose() : void
      {
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         bg.graphics.alpha = !!_loc3_?0.6:0.3;
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            if(isInHover)
            {
               if(!hoverFilter)
               {
                  hoverFilter = new ColorMatrixFilter();
                  hoverFilter.adjustBrightness(0.1);
               }
               if(_container.filter != hoverFilter)
               {
                  if(defaultFilter != _container.filter)
                  {
                     if(defaultFilter)
                     {
                        defaultFilter.dispose();
                     }
                     defaultFilter = _container.filter;
                  }
                  _container.filter = hoverFilter;
               }
            }
            else
            {
               _container.filter = defaultFilter;
            }
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         this.container.useHandCursor = true;
         icon.graphics.visible = false;
      }
      
      override protected function getClickData() : *
      {
         return this;
      }
   }
}
