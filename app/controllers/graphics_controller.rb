class GraphicsController < ApplicationController
    def index
        key = params.permit(:key)[:key]

        # section_keys = Measure.where(name: "section").pluck(:key).uniq.compact
        # .map{|k| (k || "").scan(/\/us\/usc\/t\d+\/s\d+\//)[0] }.uniq.compact

        # query = Measure.where("key ilike ?", "/us/usc/t5/s8953%")
        # num_symbols = query.sum("length(body)") - (query.count - 1)*76

        # sizes = section_keys.map do |k|
        #     query = Measure.where("key ilike ?", k + "/%").
        #         or(Measure.where(key: k)).
        #         select("sum(length(body)), count(*)").
        #         as_json[0]
        #     puts query.inspect
        #     [k, query["sum"] - ((query["count"] - 1) * 76)]
        # end.to_h

        # render json: sizes

        query = Measure
        query = query.where("key ilike ?", key + "%") if key

        render json: query.select(:key, "LENGTH(measures.body)")
    end
end