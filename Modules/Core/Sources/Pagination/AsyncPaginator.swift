////
////  AsyncPaginator.swift
////  Core
////
////  Created by Серик Абдиров on 24.09.2024.
////  Copyright © 2024 Spider Group. All rights reserved.
////
//
//import UIKit
//
//public class AsyncPaginator<PageModel: PaginatedModel, Item>: NSObject {
//    public typealias LoadActionProvider = () async throws -> (PageModel, [Item])
//    public typealias LoadMoreActionProvider = (_ nextPage: PageModel.Page) async throws -> (PageModel, [Item])
//    public typealias RefreshActionProvider = () async throws -> (PageModel, [Item])
//    
//    // MARK: - Public properties
//    
//    public private(set) var page: PageModel?
//    public private(set) var items: [Item] = []
//    
//    public var canLoadMore: Bool { page?.nextPage() != nil }
//    public var targetScrollView: UIScrollView? {
//        didSet {
//            if targetScrollView != oldValue {
//                observe(targetScrollView)
//            }
//            oldValue?.refreshControl?.removeTarget(self, action: nil, for: .valueChanged)
//        }
//    }
//    
//    /// Called when items fully reloaded
//    public var itemsChangedHandler: (([Item]) -> Void)?
//    /// Called when new items appended
//    public var itemsAppendedHandler: (([Item]) -> Void)?
//    
//    // MARK: - Private properties
//    
//    private let loadActionProvider: LoadActionProvider
//    private let moreActionProvider: LoadMoreActionProvider
//    private let refreshActionProvider: RefreshActionProvider
//    private let shouldLoadMoreProvider: ShouldLoadMoreProvider
//    
//    private var loadTask: Task<Void, any Error>?
//    private var loadMoreTask: Task<Void, any Error>?
//    private var refreshTask: Task<Void, any Error>?
//    
//    private var shouldStartRefreshing = false
//    private var isLoading = false
//    private var isRefreshing = false
//    private var isLoadingMore = false
//    
//    private var scrollViewObservation: NSKeyValueObservation?
//    private var scrollViewContentSizeObservation: NSKeyValueObservation?
//    
//    // MARK: - Init
//    
//    public init(
//        loadActionProvider: @escaping LoadActionProvider,
//        moreActionProvider: @escaping LoadMoreActionProvider,
//        refreshActionProvider: @escaping RefreshActionProvider,
//        shouldLoadMoreProvider: ShouldLoadMoreProvider = .verticalOffset(250)
//    ) {
//        self.loadActionProvider = loadActionProvider
//        self.moreActionProvider = moreActionProvider
//        self.refreshActionProvider = refreshActionProvider
//        self.shouldLoadMoreProvider = shouldLoadMoreProvider
//        super.init()
//    }
//    
//    // MARK: - Public methods
//    
//    public func startLoading() {
//        targetScrollView?.refreshControl?.endRefreshing()
//        cancelCurrentTasks()
//        
//        loadTask = Task.detached(priority: .background) { [weak self] in
//            guard let self else { return }
//            
//            isLoading = true
//            
//            let (page, items) = try await loadActionProvider()
//            await targetScrollView?.refreshControl?.endRefreshing()
//            await reload(page: page, items: items)
//            
//            isLoading = false
//        }
//    }
//    
//    @objc
//    public func startRefreshing() {
//        cancelCurrentTasks()
//        
//        refreshTask = Task.detached(priority: .background) { [weak self] in
//            guard let self else { return }
//            
//            isRefreshing = true
//            
//            let (page, items) = try await refreshActionProvider()
//            await reload(page: page, items: items)
//            
//            isRefreshing = false
//            
//            await targetScrollView?.refreshControl?.endRefreshing()
//        }
//    }
//    
//    public func update(item: Item, index: Int) {
//        // TODO: - нужен механизм синхронизации items
//        items[index] = item
//    }
//
//    // MARK: - Private methods
//
//    private func observe(_ scrollView: UIScrollView?) {
//        scrollViewObservation = targetScrollView?
//            .observe(\.contentOffset, options: [.initial, .new]) { [weak self] object, _ in
//                self?.scrollViewDidScroll(object)
//            }
//        scrollViewContentSizeObservation = targetScrollView?
//            .observe(\.contentSize, options: [.new]) { [weak self] object, _ in
//                self?.scrollViewDidScroll(object)
//            }
//        targetScrollView?.refreshControl?.addTarget(self, action: #selector(scheduleRefreshing), for: .valueChanged)
//    }
//
//    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if shouldStartRefreshing, scrollView.isDecelerating {
//            shouldStartRefreshing = false
//            startRefreshing()
//            return
//        }
//
//        if !isLoadingMore, !isRefreshing, !isLoading,
//           let nextPage = page?.nextPage(),
//           shouldLoadMoreProvider.shouldLoadMore(scrollView)
//        {
//            cancelCurrentTasks()
//
//            loadMoreTask = Task(priority: .background) { [weak self] in
//                guard let self else { return }
//
//                isLoadingMore = true
//
//                let (newPage, newItems) = try await moreActionProvider(nextPage)
//
//                page = newPage
//                items.append(contentsOf: newItems)
//
//                itemsAppendedHandler?(newItems)
//
//                isLoadingMore = false
//            }
//        }
//    }
//
//    private func reload(page: PageModel, items: [Item]) async {
//        self.page = page
//        self.items = items
//        itemsChangedHandler?(items)
//    }
//
//    private func cancelCurrentTasks() {
//        loadTask?.cancel()
//        loadMoreTask?.cancel()
//        refreshTask?.cancel()
//
//        loadTask = nil
//        loadMoreTask = nil
//        refreshTask = nil
//    }
//
//    @objc
//    private func scheduleRefreshing() {
//        shouldStartRefreshing = true
//    }
//}
