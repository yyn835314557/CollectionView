# The Summary of the UICOllectionView 
**参考网络教程，自己总结而来**
***

* [UICollectionViewCustomLayout](/Pinterest)
	 1. Core Layout Process(核心布局的处理过程)
		继承UICollectionViewLayout必须实现如下方法：
			- prepareLayout():
				 布局将要生效在方法里面计算好item的position，collection的size
			- collectionViewContentSize()
				 返回CollectionViewContentSize 不是size(width,height)，contentSize一般比size要大 
			- layoutAttributeForElementsInRect()
				 返回特定区域内的布局属性
	 2. Calculating Layout Attributes(计算 布局的属性)
	 			 
* UICollectionViewFlowLayout

## eg 1. FlickrSearch 
![1](Resource/1-2.png)
![2](Resource/1-1.png)

## eg 2. Photomania  
![3](Resource/2-1.png)
![4](Resource/2-2.png)

## eg 3. UICollectionFlowLayout
![5](Resource/3-1.png)
![6](Resource/3-2.png)

## eg 4. UICollectionViewDelegateFlowLayout 
![7](Resource/4-1.png)


