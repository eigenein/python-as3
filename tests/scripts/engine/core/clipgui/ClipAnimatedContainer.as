package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import feathers.core.FeathersControl;
   import game.view.gui.components.ClipLabel;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class ClipAnimatedContainer extends GuiClipNestedContainer implements IGuiAnimatedContainer
   {
       
      
      private var clip:Clip;
      
      private var layers:Vector.<DisplayObject>;
      
      private var layerPresentedToken:int = 0;
      
      private var layerIsPresented:Vector.<LayerTokenCounter>;
      
      private var toggleElementsVisibility:Boolean;
      
      private var forsedTimeDelta:Number = 0;
      
      public const playback:GuiPlayback = new GuiPlayback(this);
      
      public function ClipAnimatedContainer(param1:Boolean = false)
      {
         layers = new Vector.<DisplayObject>();
         layerIsPresented = new Vector.<LayerTokenCounter>();
         super();
         this.toggleElementsVisibility = param1;
      }
      
      public function dispose() : void
      {
         graphics.removeEventListener("enterFrame",onEnterFrame);
      }
      
      public function get length() : Number
      {
         if(clip.timeLine == null)
         {
            ClipImageCache.disposedClipError("ClipAnimatedContainer",clip.className);
            return 0;
         }
         return clip.timeLine.length;
      }
      
      public function set doPlayWithEnterFrame(param1:Boolean) : void
      {
         if(param1)
         {
            graphics.addEventListener("enterFrame",onEnterFrame);
         }
         else
         {
            graphics.removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         super.setNode(param1);
         this.clip = param1.clip;
         var _loc2_:Container = clip.timeLine[0] as Container;
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_.nodes;
         for each(var _loc5_ in _loc2_.nodes)
         {
            _loc6_ = container.getChildByName(_loc5_.state.name);
            if(_loc6_)
            {
               _loc4_ = layers.length;
               if(_loc5_.layer > _loc4_)
               {
                  layers.length = _loc5_.layer + 1;
                  layerIsPresented.length = _loc5_.layer + 1;
               }
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  if(layers[_loc3_] == _loc6_)
                  {
                     layerIsPresented[_loc5_.layer] = layerIsPresented[_loc3_];
                     break;
                  }
                  _loc3_++;
               }
               if(_loc3_ == _loc4_)
               {
                  layerIsPresented[_loc5_.layer] = new LayerTokenCounter();
               }
               layers[_loc5_.layer] = _loc6_;
            }
         }
         graphics.addEventListener("enterFrame",onEnterFrame);
      }
      
      public function setFrame(param1:int) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function advanceTimeTo(param1:Number) : void
      {
         setFrame(param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         playback.advanceTime(param1);
      }
      
      public function forseTimeSync(param1:Number) : void
      {
         forsedTimeDelta = forsedTimeDelta + param1;
         playback.advanceTime(param1);
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         var _loc2_:* = Number(param1.data);
         if(forsedTimeDelta > 0)
         {
            if(forsedTimeDelta < _loc2_)
            {
               _loc2_ = Number(_loc2_ - forsedTimeDelta);
            }
            else
            {
               _loc2_ = 0;
            }
            forsedTimeDelta = forsedTimeDelta + _loc2_;
         }
         playback.advanceTime(_loc2_);
      }
   }
}

class LayerTokenCounter
{
    
   
   public var token:int;
   
   function LayerTokenCounter()
   {
      super();
   }
}
