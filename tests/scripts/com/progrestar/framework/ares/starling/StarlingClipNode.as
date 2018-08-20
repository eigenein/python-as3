package com.progrestar.framework.ares.starling
{
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipCache;
   import com.progrestar.framework.ares.core.ClipImage;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.IContent;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.events.ClipEventTimeline;
   import com.progrestar.framework.ares.events.IClipEvent;
   import com.progrestar.framework.ares.extension.SoundDataExtension;
   import flash.geom.Matrix;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.FragmentFilter;
   
   public class StarlingClipNode
   {
      
      private static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      private static var pool:Vector.<StarlingClipNode> = new Vector.<StarlingClipNode>(0);
      
      protected static var stateFilterCache:StateFilterCache = new StateFilterCache();
       
      
      protected var layer:int;
      
      protected var view:Sprite;
      
      private var internalStructure:Boolean;
      
      protected var clip:Clip;
      
      var blendMode:String;
      
      var state:State;
      
      var skin:ClipSkin;
      
      var token:int;
      
      private var content:IContent;
      
      protected var children:Vector.<StarlingClipNode>;
      
      protected var childrenCount:int = 0;
      
      private var lastChildIndex:int = -1;
      
      private var lastColorMode:int = -1;
      
      private var imageData:Vector.<ClipFrame>;
      
      private var image:Image;
      
      private var dirtyAnimation:Boolean = true;
      
      private var _frameIndex:int = -1;
      
      private var lastInvertedResolution:Number = 1;
      
      protected var lastMatrix:Matrix;
      
      private var _frameKey:int;
      
      private var _frameImage:ClipImage;
      
      private var frame:Frame;
      
      public function StarlingClipNode(param1:Sprite)
      {
         children = new Vector.<StarlingClipNode>();
         super();
         this.view = param1;
      }
      
      public static function clearFilterCache() : void
      {
         stateFilterCache.clear();
      }
      
      public static function create(param1:Sprite = null) : StarlingClipNode
      {
         if(param1 == null)
         {
            param1 = new Sprite();
         }
         var _loc2_:StarlingClipNode = new StarlingClipNode(param1);
         _loc2_.internalStructure = false;
         return _loc2_;
      }
      
      protected static function createInternal(param1:int) : StarlingClipNode
      {
         var _loc2_:StarlingClipNode = !!pool.length?pool.pop():new StarlingClipNode(new Sprite());
         _loc2_.blendMode = "auto";
         _loc2_.internalStructure = true;
         _loc2_.layer = param1;
         return _loc2_;
      }
      
      public static function applyState(param1:DisplayObject, param2:State) : void
      {
         assert(param1 != null && param2 != null);
         if(param1 == null || param2 == null)
         {
            return;
         }
         param1.transformationMatrix = param2.matrix;
         stateFilterCache.setupColor(param1,param2);
         param1.alpha = param2.colorMode == 1?param2.colorAlpha:1;
      }
      
      public final function get frameIndex() : int
      {
         return !!clip?_frameIndex:-1;
      }
      
      public function get graphics() : Sprite
      {
         return view;
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public final function release() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = children;
         for each(var _loc1_ in children)
         {
            if(_loc1_)
            {
               _loc1_.release();
            }
         }
         view.dispose();
      }
      
      private final function freeCurrentFrame() : void
      {
         if(imageData != null)
         {
            imageData = null;
            _frameImage = null;
         }
         content = null;
         frame = null;
         clip = null;
         skin = null;
         childrenCount = 0;
         _frameKey = -1;
      }
      
      public function setTransformationMatrix(param1:Matrix = null) : void
      {
         lastMatrix = param1;
         if(param1)
         {
            view.transformationMatrix = param1;
         }
      }
      
      public function setup(param1:Clip, param2:State, param3:int, param4:String = null, param5:ClipSkin = null) : void
      {
         var _loc7_:* = undefined;
         if(param1.resource == null)
         {
            ClipImageCache.disposedClipError("StarlingClipNode",param1.className);
            return;
         }
         blendMode = param4 && param4 != "normal"?param4:param2.blendMode;
         view.blendMode = blendMode == "normal"?"auto":blendMode;
         var _loc6_:Sprite = view;
         if(param1.marker && param5)
         {
            _loc7_ = param5.getSkinPart(param1);
            if(_loc7_)
            {
               if(_loc7_ is Clip)
               {
                  param1 = _loc7_;
               }
               else
               {
                  view.addChild(_loc7_);
               }
            }
         }
         if(lastMatrix != param2.matrix || lastInvertedResolution != param1.invertedResolution)
         {
            lastMatrix = param2.matrix;
            if(!lastMatrix)
            {
               lastMatrix = IDENTITY_MATRIX;
            }
            _loc6_.transformationMatrix = lastMatrix;
         }
         stateFilterCache.setupColor(view,param2);
         if(lastColorMode != param2.colorMode)
         {
            lastColorMode = param2.colorMode;
            if(param2.colorMode != 1)
            {
               view.alpha = 0.999;
            }
         }
         if(param2.colorMode == 1)
         {
            view.alpha = param2.colorAlpha;
         }
         if(dirtyAnimation == false && (this.clip != param1 || this.state != param2 || param2.cacheHasAnimation || this.skin != param5))
         {
            this.skin = param5;
            dirtyAnimation = true;
         }
         this.clip = param1;
         this.state = param2;
         if(dirtyAnimation)
         {
            setupContent(param3,param5);
            if(param2.cacheHasAnimation)
            {
               dirtyAnimation = true;
            }
         }
         if(param1.marker && param5)
         {
            param5.setMarkerDisplayObject(param1.className,view);
         }
      }
      
      private function setupContent(param1:int, param2:ClipSkin) : void
      {
         var _loc8_:* = null;
         var _loc9_:* = undefined;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc3_:int = 0;
         var _loc7_:int = _frameIndex;
         var _loc5_:uint = clip.timeLine.length;
         if(param1 >= 0)
         {
            _frameIndex = param1 % _loc5_;
         }
         else
         {
            _frameIndex = _loc5_ + (param1 + 1) % _loc5_ - 1;
         }
         if(param2 != null)
         {
            _loc8_ = SoundDataExtension.fromAsset(clip.resource);
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.getClipSoundEvents(clip);
               if(_loc9_ != null)
               {
                  ClipEventTimeline.playEvents(_loc9_,_loc7_,_frameIndex,param2.playSoundFromEvent);
               }
            }
         }
         var _loc4_:IContent = !!_loc5_?clip.timeLine[_frameIndex]:null;
         dirtyAnimation = _loc5_ > 1;
         token = Number(token) + 1;
         if(_loc4_ is Container)
         {
            setContainer(_loc4_ as Container,_loc5_ > 1?_frameIndex:int(param1),param2);
         }
         if(content != _loc4_)
         {
            content = _loc4_;
            if(childrenCount)
            {
               removeChildrenWithOutdatedToken();
            }
            if(_loc4_ is Frame)
            {
               _loc6_ = _loc4_ as Frame;
               _loc10_ = null;
               if(param2 != null)
               {
                  _loc10_ = param2.getFrameTexture(_loc6_);
               }
               else
               {
                  if(_loc6_.image != _frameImage)
                  {
                     _frameImage = _loc6_.image;
                     imageData = ClipImageCache.getImageTextures(_frameImage);
                  }
                  _loc3_ = _loc6_.id;
                  if(imageData && imageData.length > _loc3_)
                  {
                     _loc10_ = imageData[_loc3_];
                  }
               }
               if(_loc10_ != null)
               {
                  setClipFrame(_loc10_);
               }
               else
               {
                  _loc6_ = null;
               }
            }
            if(_loc6_ == null && image && image.parent)
            {
               view.removeChild(image);
            }
         }
      }
      
      protected function setContainer(param1:Container, param2:int, param3:ClipSkin) : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc9_:* = null;
         if(!param1.firstFrameByNode)
         {
            ClipCache.cacheClip(clip);
         }
         var _loc5_:Vector.<Node> = param1.nodes;
         var _loc7_:uint = _loc5_.length;
         if(_loc7_ == 0)
         {
            return;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_ = _loc5_[_loc8_];
            _loc6_ = param1.firstFrameByNode[_loc8_];
            _loc9_ = null;
            if(_loc4_.layer < children.length)
            {
               _loc9_ = children[_loc4_.layer];
            }
            if(_loc9_ == null)
            {
               _loc9_ = createLayer(_loc4_.layer);
            }
            if(_loc9_.view.parent == view)
            {
               view.setChildIndex(_loc9_.view,_loc8_);
            }
            _loc9_.lastChildIndex = _loc8_;
            _loc9_.setup(_loc4_.clip,_loc4_.state,param2 - _loc6_,blendMode,param3);
            _loc9_.token = token;
            dirtyAnimation = dirtyAnimation || _loc9_.dirtyAnimation;
            _loc8_++;
         }
      }
      
      protected function createLayer(param1:uint) : StarlingClipNode
      {
         if(children.length <= param1)
         {
            children.length = param1 + 1;
         }
         var _loc3_:* = createInternal(param1);
         children[param1] = _loc3_;
         var _loc2_:StarlingClipNode = _loc3_;
         view.addChild(_loc2_.view);
         childrenCount = Number(childrenCount) + 1;
         return _loc2_;
      }
      
      private function removeChildren() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function removeChildrenWithOutdatedToken() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function setClipFrame(param1:ClipFrame) : void
      {
         if(image)
         {
            image.texture = param1.texture;
            image.readjustSize();
         }
         else
         {
            image = new Image(param1.texture);
         }
         var _loc2_:* = 1;
         if(clip.resource.invertedResolution != clip.resource.invertedResolution)
         {
            _loc2_ = Number(clip.invertedResolution);
         }
         image.x = -0.5 * param1.texture.width * _loc2_ - param1.x * 0.5 * _loc2_;
         image.y = -0.5 * param1.texture.height * _loc2_ - param1.y * 0.5 * _loc2_;
         image.scaleX = _loc2_;
         image.scaleY = _loc2_;
         view.addChild(image);
      }
      
      public final function restart() : void
      {
         dirtyAnimation = true;
         token = Number(token) + 1;
         removeChildren();
      }
      
      public final function clear() : void
      {
         token = 0;
         lastMatrix = null;
         lastChildIndex = -1;
         removeChildren();
      }
   }
}
